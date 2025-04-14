const express = require('express');
const { createScheduleItem, getScheduleByGroup } = require('../controllers/scheduleController');

const router = express.Router();

router.post('/', createScheduleItem);
router.get('/:groupId', getScheduleByGroup);

module.exports = router;
