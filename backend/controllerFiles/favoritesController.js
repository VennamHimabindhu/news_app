const Favorite = require('../models/Favorite');

// Get all favorite articles
const getFavorites = async (req, res) => {
  try {
    const favorites = await Favorite.find();
    res.json(favorites);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching favorites', error });
  }
};

// Add a new favorite article
const addFavorite = async (req, res) => {
  try {
    const newFavorite = new Favorite(req.body);
    await newFavorite.save();
    res.status(201).json(newFavorite);
  } catch (error) {
    res.status(400).json({ message: 'Error adding favorite', error });
  }
};

// Delete a favorite article by URL
const deleteFavorite = async (req, res) => {
  try {
    const url = decodeURIComponent(req.params.url);
    const result = await Favorite.deleteOne({ url });

    if (result.deletedCount === 0) {
      return res.status(404).json({ message: 'Favorite not found' });
    }

    res.json({ message: 'Favorite deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting favorite', error });
  }
};

module.exports = {
  getFavorites,
  addFavorite,
  deleteFavorite
};
