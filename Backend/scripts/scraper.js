import dotenv from "dotenv";
dotenv.config();
import axios from "axios";
import * as cheerio from "cheerio";
import mongoose from "mongoose";
import { RecursiveCharacterTextSplitter } from "langchain/text_splitter";
import { HuggingFaceInferenceEmbeddings } from "@langchain/community/embeddings/hf";

//MongoDB Connection
await mongoose.connect(process.env.MONGO_URI, {
  dbName: "msail_db",
});
console.log("MongoDB Connected to msail_db");

//Schema for chunks collection
const ChunkSchema = new mongoose.Schema({
  parentUrl: String,
  parentQuestion: String,
  text: String,
  embedding: [Number],
});

const Chunk = mongoose.model("Chunk", ChunkSchema, "chunks");

//URLs to scrape
const urls = [
  "https://islamqa.info/en/answers/113676",
  "https://islamqa.info/en/answers/132959",
  "https://islamqa.info/en/answers/286098",
  "https://islamqa.info/en/answers/121684",
  "https://islamqa.info/en/answers/129095",
  "https://islamqa.info/en/answers/290308",
  "https://islamqa.info/en/answers/20677",
  "https://islamqa.info/en/answers/132234",
  "https://islamqa.info/en/answers/134495",
  "https://islamqa.info/en/answers/106520"
];

//HuggingFace Inference Embeddings Model
const embeddingsModel = new HuggingFaceInferenceEmbeddings({
  model: "sentence-transformers/all-MiniLM-L6-v2", // outputs 384-dim
  apiKey: process.env.HF_API_KEY,
});

//Scraper Function
async function scrapeFatwa(url) {
  try {
    const { data } = await axios.get(url, {
      headers: { "User-Agent": "Mozilla/5.0" },
    });

    const $ = cheerio.load(data);

    const question = $("h1").text().trim();
    const answer = $(".SUT_answer_text")
      .map((_, el) => $(el).text().trim())
      .get()
      .join("\n\n");

    if (!question || !answer) {
      console.log(`Could not extract from ${url}`);
      return;
    }

    // Step 1: Split text into chunks
    const splitter = new RecursiveCharacterTextSplitter({
      chunkSize: 1000,
      chunkOverlap: 100,
    });
    const chunks = await splitter.splitText(answer);

    // Step 2: Embed and save each chunk separately
    for (const chunk of chunks) {
      const embedding = await embeddingsModel.embedQuery(chunk);

      await Chunk.updateOne(
        { parentUrl: url, text: chunk }, // prevent duplicates
        { parentUrl: url, parentQuestion: question, text: chunk, embedding },
        { upsert: true }
      );
    }

    console.log(`Saved chunks for: ${question}`);
  } catch (err) {
    console.error(`Failed to scrape ${url}: ${err.message}`);
  }
}

//Run All
async function run() {
  for (const url of urls) {
    await scrapeFatwa(url);
  }
  console.log("Scraping + Chunk Storage Finished");

  await mongoose.disconnect();
  console.log("MongoDB disconnected");
}

run();
