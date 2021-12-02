const mongoose = require("mongoose");

const ProblemSchema = new mongoose.Schema(
  {
    description: {
      type: String,
      required: true,
    },
    solved: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Problem", ProblemSchema);
