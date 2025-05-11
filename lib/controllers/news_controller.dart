import 'dart:developer';
import 'package:get/get.dart';
import '../models/article_model.dart';
import '../services/news_service.dart';
import '../services/favorites_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();
  final FavoritesService _favoritesService = FavoritesService();

  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var favorites = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
    loadFavoritesFromBackend();
  }

  /// Fetch articles from News API
  void fetchArticles() async {
    try {
      isLoading(true);
      final fetchedArticles = await _newsService.fetchArticles();
      articles.assignAll(fetchedArticles);
      log('✅ Articles fetched: ${fetchedArticles.length}');
    } catch (e, stackTrace) {
      log('❌ Error fetching articles: $e', stackTrace: stackTrace);
    } finally {
      isLoading(false);
    }
  }

  /// Toggle favorite article
  void toggleFavorite(Article article) async {
    try {
      if (isFavorite(article)) {
        favorites.removeWhere((a) => a.url == article.url);
        await _favoritesService.deleteFavorite(article.url);
      } else {
        favorites.add(article);
        await _favoritesService.addFavorite(article);
      }
    } catch (e) {
      log('❌ Error toggling favorite: $e');
    }
  }

  /// Check if an article is a favorite
  bool isFavorite(Article article) {
    return favorites.any((a) => a.url == article.url);
  }

  /// Load favorites from backend
  void loadFavoritesFromBackend() async {
    try {
      final fetchedFavorites = await _favoritesService.fetchFavorites();
      favorites.assignAll(fetchedFavorites);
      log('📥 Favorites loaded: ${fetchedFavorites.length}');
    } catch (e) {
      log('❌ Error loading favorites: $e');
    }
  }
}
