import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  final String _apiKey = 'b5b68c95ab534847abb1b3faa9205263';
  final String _baseUrl = 'https://newsapi.org/v2';

  /// Fetches top headlines from the US
  Future<List<Article>> fetchArticles() async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey');

    final response = await http.get(url);

    // ✅ Use log instead of print
    log('🔵 Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'] ?? [];

      return articlesJson
          .map((jsonItem) => Article.fromJson(jsonItem))
          .toList();
    } else {
      throw Exception('❌ Failed to load articles. Status code: ${response.statusCode}');
    }
  }
}
