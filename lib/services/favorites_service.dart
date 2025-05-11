import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class FavoritesService {
  final String baseUrl = 'http://localhost:5000/api/favorites'; // Update with your deployed URL

  Future<List<Article>> fetchFavorites() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> addFavorite(Article article) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(article.toJson()),
    );
  }

  Future<void> deleteFavorite(String url) async {
    await http.delete(Uri.parse('$baseUrl/${Uri.encodeComponent(url)}'));
  }
}
