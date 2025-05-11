const express = require('express');
const router = express.Router();
const { getNews } = require('../controllerFiles/newsCtrl');

router.get('/', getNews);

module.exports = router;
