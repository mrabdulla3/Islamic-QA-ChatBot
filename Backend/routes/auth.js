import express from "express";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import User from "../model/user.js";
import dotenv from "dotenv";
dotenv.config();

const router = express.Router();

router.post("/signup", async (req, res) => {
    try {
        console.log("Signup body:", req.body);
        const { name, email, password } = req.body;
        if (!name || !email || !password) {
            return res.status(400).json({ message: "Name, email and password are required" });
        }
        const existUser = await User.findOne({ email });
        if (existUser) return res.status(400).json({ message: "User already exists" });

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new User({ name, email, password: hashedPassword });
        newUser.save();

        res.status(201).json({ message: "User created successfully" });
    } catch (e) {
        res.status(500).json({ message: err.message });
    }

});

router.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const userExist = await User.findOne({ email });
        if (!userExist) return res.status(400).json({ message: "User not found" });

        const isMatch = await bcrypt.compare(password, userExist.password);
        if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

        const token = jwt.sign({ id: userExist._id }, process.env.JWT_SECRET, { expiresIn: "1d" });
        res.json({ token, user: { id: userExist._id, name: userExist.name, email: userExist.email } });
    } catch (e) {
        res.status(500).json({ message: err.message });
    }

});

export default router;