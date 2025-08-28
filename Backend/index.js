import express from "express";
import cors from "cors";
import mongoose from "mongoose";
import dotenv from "dotenv";
import askRoute from "./routes/fatwaRoutes.js";
import authRoutes from "./routes/auth.js";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

//Database connection
mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB Connected"))
  .catch(err => console.log(err));

//Routes
app.use("/api/auth", authRoutes);
app.use("/api", askRoute);

app.listen(process.env.PORT, () => {
  console.log(`Server running on http://localhost:${process.env.PORT}`);
});
