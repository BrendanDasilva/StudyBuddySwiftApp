const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema({
  title: String,
  content: String,
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  groupId: { type: mongoose.Schema.Types.ObjectId, ref: 'Group' },
  visibility: { type: String, enum: ['private', 'group', 'public'], default: 'private' }
});

module.exports = mongoose.model('Note', noteSchema);
