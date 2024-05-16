const mongoose = require("mongoose");

const historySchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  imageUrl: {
    type: String,
    required: true,
  },
  time: {
    type: Date,
    required: true,
  },
});

const History = mongoose.model("History", historySchema);

module.exports = History;
