const Flashcard = require('../models/Flashcard');

const createFlashcard = async (req, res) => {
  try {
    const flashcard = new Flashcard(req.body);
    await flashcard.save();
    res.status(201).json(flashcard);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const getFlashcardsByGroup = async (req, res) => {
  try {
    const flashcards = await Flashcard.find({
      $or: [
        { groupId: req.params.groupId },
        { visibility: 'public' }
      ]
    }).populate('createdBy');
    res.json(flashcards);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { createFlashcard, getFlashcardsByGroup };
