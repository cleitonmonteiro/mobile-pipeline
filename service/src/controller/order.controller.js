const Order = require("../models/order.model");

const create = (req, res) => {
  // Validate request
  const { description } = req.body;
  if (!description) {
    res.status(400).send({ message: "Description can not be empty!" });
    return;
  }

  const newOrder = new Order({
    description,
  });

  newOrder
    .save(newOrder)
    .then((data) => {
      console.log("Created order: ", data);
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    });
};

const findAll = async (req, res) => {
  const orders = await Order.find(req.body);
  console.log(req.body);
  console.log("Orders size: ", orders?.length);
  return res.json(orders);
};

const updateOne = (req, res) => {
  const { id } = req.params;

  Order.findByIdAndUpdate(id, req.body)
    .then((data) => {
      if (data) {
        res.send({ message: "Order was updated sucessfully." });
      } else {
        res.status(404).send({
          message: `Cannot update Order with id=${id}.`,
        });
      }
    })
    .catch((err) => {
      res.status(500).send({
        message: "Error updating order with id=" + id,
      });
    });
};

const deleteAll = (req, res) => {
  Order.deleteMany({})
    .then((data) => {
      res.send({
        message: `${data.deletedCount} Orders were deleted successfully!`,
      });
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all orders.",
      });
    });
};

module.exports = {
  create,
  findAll,
  updateOne,
  deleteAll,
};
