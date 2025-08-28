import { HuggingFaceInferenceEmbeddings } from "@langchain/community/embeddings/hf";
import { MongoDBAtlasVectorSearch } from "@langchain/mongodb";
import { MongoClient } from "mongodb";
import dotenv from "dotenv";
dotenv.config();


// HuggingFace embeddings instance
const embeddings = new HuggingFaceInferenceEmbeddings({
  apiKey: process.env.HF_API_KEY,
  model: "sentence-transformers/all-MiniLM-L6-v2", 
});

// Mongo client
const client = new MongoClient(process.env.MONGO_URI);
const dbName = "msail_db";
const collectionName = "chunks";

// Function to connect vector store
export async function getVectorStore() {
  await client.connect();
  const collection = client.db(dbName).collection(collectionName);

  const vectorStore = new MongoDBAtlasVectorSearch(embeddings, {
    collection,
    indexName: "msail_vector_index",
    textKey: "text",
    embeddingKey: "embedding",
  });

  return vectorStore;
}
