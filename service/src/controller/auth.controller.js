const User = require("../models/user.model");

const login = async (req, res) => {
  const { username, token } = req.body;
  if (!username || !token) {
    return res.status(400).send({
      message: "The username/token cannot be empty.",
    });
  }
  const user = await User.findOne({ username });
  if (user) {
    console.log("User found!");
    return res.send(user);
  }

  const newUser = await User.create({ username, token });
  if (newUser) {
    console.log("New user created!");
    return res.status(201).send(newUser);
  }
  return res.status(400).send({
    message: "Cannot found or create a new user.",
  });
};

module.exports = {
  login,
};
