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
![horizontal_collage](https://github.com/user-attachments/assets/2e976e98-9e33-40bf-8207-e21ba9ea303a)




