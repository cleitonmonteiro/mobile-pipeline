const mongoose = require("mongoose");

const OrderSchema = new mongoose.Schema(
  {
    description: {
      type: String,
      required: true,
    },
    delivered: {
      type: Boolean,
      required: false,
      default: false,
    },
    received: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Order", OrderSchema);
