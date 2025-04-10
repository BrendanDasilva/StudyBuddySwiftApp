const express = require('express');
const { createFlashcard, getFlashcardsByGroup } = require('../controllers/flashcardController');

const router = express.Router();

router.post('/', createFlashcard);
router.get('/:groupId', getFlashcardsByGroup);

module.exports = router;
