// routes/fatwaRoutes.js
import express from "express";
import { getVectorStore } from "../utils/vectorStore.js";
import dotenv from "dotenv";
import Groq from "groq-sdk";
dotenv.config();

const router = express.Router();
const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });

const hfApiKey = process.env.HF_API_KEY;
// POST /api/ask
router.post("/ask", async (req, res) => {
  try {
    const { query } = req.body;

    if (!query) {
      return res.status(400).json({ error: "Query is required" });
    }
    //console.log("1");
    const vectorStore = await getVectorStore();
    // console.log("2");
    // Perform similarity search
    const results = await vectorStore.similaritySearch(query, 3); // top 3 answers

    // 2️⃣ Combine top results into context
    const combinedText = results
      .map(
        (r) =>
          `Question: ${r.metadata?.question || "Unknown"}\nAnswer: ${r.pageContent
          }`
      )
      .join("\n\n");

    // Enhanced instructions
    const messages = [
      {
        role: "system",
        content: `
You are a respectful and knowledgeable Islamic QA assistant. 
Your job is to answer the user's question based ONLY on the provided fatwa context.
Guidelines:
- Use the fatwa wording as much as possible.
- Write clearly and concisely (2–4 sentences max).
- If multiple fatwas overlap, merge them into a single unified answer without repeating.
- If the context does not clearly contain an answer, reply: "The provided fatwas do not give a clear answer."
- Never invent or add information outside of the given fatwas.
- Maintain a polite and scholarly tone.
        `
      },
      {
        role: "user",
        content: `
User Question: ${query}

Relevant Fatwas:
${combinedText}

Now, provide the best possible concise answer in a respectful tone:
        `
      }
    ];
    // 3️⃣ Call Groq API (LLaMA 3 free model)
    const completion = await groq.chat.completions.create({
      model: "llama3-8b-8192", // ✅ free & fast Groq model
      messages
    });

    const generatedAnswer =
      completion.choices[0]?.message?.content || "No answer generated";

    // 4️⃣ Return response
    res.json({
      query,
      results: results.map((r) => ({
        question: r.metadata?.question || "Unknown",
        answer: r.pageContent,
        score: r.score,
      })),
      llmAnswer: generatedAnswer,
    });
  } catch (err) {
    console.error("HuggingFace error:", err.response[0]?.data || err.message);
    res.status(500).json({ error: "Something went wrong" });
  }
});

export default router;
