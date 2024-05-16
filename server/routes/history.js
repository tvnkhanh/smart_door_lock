require("dotenv").config();

const express = require("express");
const historyRouter = express.Router();
const multer = require("multer");
const cloudinary = require("cloudinary").v2;
const noAuth = require("../middleware/no_auth");
const validateHistory = require("../middleware/validate_history");
const streamifier = require('streamifier');

const History = require("../models/history");

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

const storage = multer.memoryStorage();
const upload = multer({ storage });

historyRouter.get("/api/get-history", noAuth, async (req, res, next) => {
  try {
    const history = await History.find();
    res.json(history);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

historyRouter.post("/api/add-history", upload.single('image'), async (req, res, next) => {
  try {
    const { name } = req.body;
    const file = req.file;

    if (!file) {
        return res.status(400).json({ error:'Image file is required' });
    }

    const streamUpload = () => {
        return new Promise((resolve, reject) => {
            const stream = cloudinary.uploader.upload_stream(
                { folder: process.env.CLOUDINARY_FOLDER_NAME },
                (error, result) => {
                    if (result) {
                        resolve(result);
                    } else {
                        reject(error);
                    }
                }
            );
            streamifier.createReadStream(file.buffer).pipe(stream);
        });
    }

    const result = await streamUpload();

    let history = new History({
        name: name,
        imageUrl: result.secure_url,
        time: new Date(),
    });

    history = await history.save();
    res.json(history);  
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = historyRouter;
