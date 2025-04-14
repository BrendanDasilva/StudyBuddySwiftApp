const Note = require('../models/Note');

const createNote = async (req, res) => {
  try {
    const note = new Note(req.body);
    await note.save();
    res.status(201).json(note);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const getNotesByGroup = async (req, res) => {
  try {
    const notes = await Note.find({
      $or: [
        { groupId: req.params.groupId },
        { visibility: 'public' }
      ]
    }).populate('createdBy');
    res.json(notes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { createNote, getNotesByGroup };
