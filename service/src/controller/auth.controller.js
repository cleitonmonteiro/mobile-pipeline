const User = require("../models/user.model");

const login = async (req, res) => {
  const { username } = req.body;
  if (!username) {
    return res.status(400).send({
      message: "The username cannot be empty.",
    });
  }
  const user = await User.findOne({ username });
  if (user) {
    return res.send(user);
  }

  const newUser = await User.create({ username });
  if (newUser) {
    return res.status(201).send(newUser);
  }
  return res.status(400).send({
    message: "Cannot found or create a new user.",
  });
};

module.exports = {
  login,
};
