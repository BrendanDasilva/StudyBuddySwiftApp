const Message = require('../models/Message');

const sendMessage = async (req, res) => {
  try {
    const { groupId, sender, content } = req.body;
    const message = new Message({ groupId, sender, content });
    await message.save();
    res.status(201).json(message);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const getMessages = async (req, res) => {
  try {
    const { groupId } = req.params;
    const messages = await Message.find({ groupId }).populate('sender');
    res.json(messages);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { sendMessage, getMessages };
