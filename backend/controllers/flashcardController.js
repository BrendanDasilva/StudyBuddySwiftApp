const Flashcard = require('../models/Flashcard');

// Create a new flashcard
const createFlashcard = async (req, res) => {
  try {
    const flashcard = new Flashcard(req.body);
    await flashcard.save();
    res.status(201).json(flashcard);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get flashcards by group or public ones
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

// Update a flashcard by its ID
const updateFlashcard = async (req, res) => {
  try {
    const { id } = req.params;
    const updatedData = req.body;

    // Find the flashcard by ID and update it
    const flashcard = await Flashcard.findByIdAndUpdate(id, updatedData, { new: true });
    if (!flashcard) {
      return res.status(404).json({ error: 'Flashcard not found' });
    }
    
    res.json(flashcard);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Delete a flashcard by its ID
const deleteFlashcard = async (req, res) => {
  try {
    const { id } = req.params;

    // Find and remove the flashcard
    const flashcard = await Flashcard.findByIdAndDelete(id);
    if (!flashcard) {
      return res.status(404).json({ error: 'Flashcard not found' });
    }

    res.status(204).send(); // No content
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { createFlashcard, getFlashcardsByGroup, updateFlashcard, deleteFlashcard };
