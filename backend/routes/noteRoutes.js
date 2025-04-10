const express = require('express');
const { createNote, getNotesByGroup } = require('../controllers/noteController');

const router = express.Router();

router.post('/', createNote);
router.get('/:groupId', getNotesByGroup);

module.exports = router;
