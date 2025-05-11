import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  final NewsController controller = Get.find(); // or Get.put() if not already registered

  HomePage({super.key}); // ❌ removed const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending News'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Get.toNamed('/search'),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorites'),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return ListTile(
              leading: article.urlToImage.isNotEmpty
    ? FadeInImage.assetNetwork(
        placeholder: 'assets/placeholder.jpg',
        image: article.urlToImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/placeholder.jpg', width: 100, height: 100, fit: BoxFit.cover);
        },
      )
    : Image.asset('assets/placeholder.jpg', width: 100, height: 100, fit: BoxFit.cover),

              title: Text(article.title),
              subtitle: Text(
                article.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Get.to(() => DetailsPage(article: article)),
              trailing: IconButton(
                icon: Icon(
                  controller.isFavorite(article)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => controller.toggleFavorite(article),
              ),
            );
          },
        );
      }),
    );
  }
}