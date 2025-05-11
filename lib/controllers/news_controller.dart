import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();

  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var favorites = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
    loadFavorites();
  }

  /// Fetch articles from API
  void fetchArticles() async {
    try {
      isLoading(true);
      final fetchedArticles = await _newsService.fetchArticles();

      log('✅ Fetched ${fetchedArticles.length} articles'); // Log the count

      articles.assignAll(fetchedArticles);
    } catch (e, stackTrace) {
      log('❌ Error fetching articles: $e', stackTrace: stackTrace);
    } finally {
      isLoading(false);
    }
  }

  /// Toggle favorite status of an article
void toggleFavorite(Article article) {
  if (isFavorite(article)) {
    favorites.removeWhere((a) => a.url == article.url);
  } else {
    favorites.add(article);
  }

  // Save in the background without blocking UI
  Future.microtask(() => saveFavorites());
}

  /// Check if article is already a favorite
  bool isFavorite(Article article) {
    return favorites.any((a) => a.url == article.url);
  }

  /// Save favorites to local storage
  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJsonList = favorites.map((article) => jsonEncode(article.toJson())).toList();
    await prefs.setStringList('favorites', favJsonList);
  }

  /// Load favorites from local storage
  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJsonList = prefs.getStringList('favorites') ?? [];

    favorites.value = favJsonList.map((item) {
      try {
        return Article.fromJson(jsonDecode(item));
      } catch (e) {
        log('⚠️ Error decoding favorite: $e');
        return null;
      }
    }).whereType<Article>().toList();
  }
}
