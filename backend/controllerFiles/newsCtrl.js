const axios = require('axios');

const getNews = async (req, res) => {
  try {
    const response = await axios.get(`https://newsapi.org/v2/top-headlines`, {
      params: {
        country: 'in', // change to 'us' or others if needed
        apiKey: process.env.NEWS_API_KEY,
      },
    });
    res.json(response.data.articles);
  } catch (error) {
    console.error('Error fetching news:', error.message);
    res.status(500).json({ message: 'Failed to fetch news' });
  }
};

module.exports = { getNews };
