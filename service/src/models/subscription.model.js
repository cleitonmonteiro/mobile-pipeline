const mongoose = require("mongoose");

const SubscriptionSchema = new mongoose.Schema(
  {
    mobileId: {
      type: String,
      required: false,
    },
    track: {
      type: Boolean,
      required: false,
      default: false,
    },
    distanceToNotifier: {
      type: Number,
      required: false,
      default: 0.0,
    },
    latitude: {
      type: Number,
      required: false,
      default: 0.0,
    },
    longitude: {
      type: Number,
      required: false,
      default: 0.0,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Subscription", SubscriptionSchema);
