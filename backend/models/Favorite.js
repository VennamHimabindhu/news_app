// models/Favorite.js
const mongoose = require('mongoose');

const FavoriteSchema = new mongoose.Schema({
  title: String,
  description: String,
  url: String,
  urlToImage: String,
  content: String,
}, { timestamps: true });

module.exports = mongoose.model('Favorite', FavoriteSchema);
