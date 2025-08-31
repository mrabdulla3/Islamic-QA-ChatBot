🕌 Islamic Q&A App

An AI-powered Islamic Question & Answer Application built with Flutter (frontend) and Node.js + Express (backend).
This project integrates RAG (Retrieval Augmented Generation) with LangChain, HuggingFace models, and a MongoDB Atlas Vector Database for semantic search on Islamic knowledge.

🚀 Features
📱 Frontend (Flutter + GetX)

✅ Islamic Q&A Chat with text + voice input 🎙️

✅ Beautiful chat UI with gradient message bubbles

✅ Long-press voice recording for searching fatwas

✅ Logout options in app bar

✅ Loading animations with Flutter Spinkit

✅ Optimized with GetX for state management

⚙️ Backend (Node.js + Express)

✅ RAG (Retrieval Augmented Generation) powered Q&A

✅ Web Scraping Islamic Q&A content → chunked & stored in MongoDB Atlas

✅ Vector Search using LangChain + MongoDB Atlas Vector DB

✅ HuggingFace Models for NLP & embeddings

✅ JWT Authentication for secure API access

✅ RESTful API integration with Flutter frontend

🧠 Tech Stack
Frontend

Flutter (Dart)

GetX (state management)

Flutter Spinkit (loading animations)

Backend

Node.js + Express

MongoDB Atlas (Vector DB)

LangChain

HuggingFace Models

JWT Authentication

Web Scraping (for dataset creation)

🔍 How It Works

User asks a question (text/voice) in the Flutter app.

Query sent to backend → JWT verified.

Backend retrieves relevant fatwa chunks from MongoDB Atlas Vector DB using vector similarity search.

LangChain + HuggingFace generate contextual response.

Answer returned & disp
ayed beautifully in Flutter chat UI.

📸 Screenshots

![Screenshot_2025-08-31-09-28-17-70_8e418417cee4b8824161cf02fc4744fb](https://github.com/user-attachments/assets/a55e9ee1-92d0-444a-9bde-6028c54618ff)
![Screenshot_2025-08-31-09-28-24-36_8e418417cee4b8824161cf02fc4744fb](https://github.com/user-attachments/assets/8e24633c-d8d8-4562-a717-02d2b4757a0e)
![Screenshot_2025-08-31-09-28-28-64_8e418417cee4b8824161cf02fc4744fb](https://github.com/user-attachments/assets/ff1397e1-bc19-42d3-aafe-c873b6bfceca)
![Screenshot_2025-08-31-09-29-07-64_8e418417cee4b8824161cf02fc4744fb](https://github.com/user-attachments/assets/41811d48-7c7c-4137-9e57-992b4f510eb7)


