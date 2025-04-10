const Schedule = require('../models/Schedule');

const createScheduleItem = async (req, res) => {
  try {
    const item = new Schedule(req.body);
    await item.save();
    res.status(201).json(item);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const getScheduleByGroup = async (req, res) => {
  try {
    const items = await Schedule.find({
      $or: [
        { groupId: req.params.groupId },
        { visibility: 'public' }
      ]
    }).populate('createdBy');
    res.json(items);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { createScheduleItem, getScheduleByGroup };
