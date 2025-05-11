const express = require('express');
const router = express.Router();
const {
  getFavorites,
  addFavorite,
  deleteFavorite
} =  require('../controllerFiles/favoritesController');

// Get all favorite articles
router.get('/', getFavorites);

// Add a new favorite
router.post('/', addFavorite);

// Delete a favorite by URL
router.delete('/:url', deleteFavorite);

module.exports = router;
