import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();

  FavoritesPage({super.key}); // Removed const to avoid runtime error with GetX

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Articles')),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet.'));
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final article = controller.favorites[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: article.urlToImage.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.jpg',
                        image: article.urlToImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/placeholder.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/placeholder.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              title: Text(article.title),
              subtitle: Text(
                article.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.toggleFavorite(article),
              ),
              onTap: () => Get.to(() => DetailsPage(article: article)),
            );
          },
        );
      }),
    );
  }
}
