const mongoose = require('mongoose');

const groupSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  members: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', 
  }],
  features: {
    type: [String],
    default: [],
  },
  topics: {
    type: [String],
    default: [],
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Group = mongoose.model('Group', groupSchema);

module.exports = Group;
