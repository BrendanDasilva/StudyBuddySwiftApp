const express = require('express');
const { createFlashcard, getFlashcardsByGroup, updateFlashcard, deleteFlashcard } = require('../controllers/flashcardController');

const router = express.Router();

// POST request to create a flashcard
router.post('/', createFlashcard);

// GET request to fetch flashcards for a specific group
router.get('/:groupId', getFlashcardsByGroup);

// PUT request to update a flashcard by ID
router.put('/:id', updateFlashcard);

// DELETE request to remove a flashcard by ID
router.delete('/:id', deleteFlashcard);

module.exports = router;
