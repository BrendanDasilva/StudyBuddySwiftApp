const mongoose = require('mongoose');

const flashcardSchema = new mongoose.Schema({
  question: String,
  answer: String,
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  groupId: { type: mongoose.Schema.Types.ObjectId, ref: 'Group' }, // optional if sharing
  visibility: { type: String, enum: ['private', 'group', 'public'], default: 'private' }
});

module.exports = mongoose.model('Flashcard', flashcardSchema);
