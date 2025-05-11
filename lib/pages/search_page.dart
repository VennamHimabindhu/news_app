import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import 'details_page.dart';
import '../models/article_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key}); // Add key for consistency

  @override
  SearchPageState createState() => SearchPageState(); // Use public class here
}

class SearchPageState extends State<SearchPage> { // Renamed to public
  final NewsController controller = Get.find<NewsController>();
  final TextEditingController searchController = TextEditingController();
  List<Article> searchResults = [];

  void performSearch(String query) {
    final allArticles = controller.articles;
    final results = allArticles
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search News')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter keyword...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => performSearch(searchController.text),
                ),
              ),
              onSubmitted: performSearch,
            ),
            SizedBox(height: 10),
            Expanded(
              child: searchResults.isEmpty
                  ? Center(child: Text('No results found.'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final article = searchResults[index];
                        return ListTile(
                          leading: article.urlToImage.isNotEmpty
                              ? Image.network(article.urlToImage, width: 80, fit: BoxFit.cover)
                              : null,
                          title: Text(article.title),
                          subtitle: Text(article.description),
                          onTap: () => Get.to(() => DetailsPage(article: article)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
