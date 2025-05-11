import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/news_controller.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/favorites_page.dart';

void main() {
  Get.put(NewsController()); // Register the controller before running the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/search', page: () => SearchPage()),
        GetPage(name: '/favorites', page: () => FavoritesPage()),
      ],
    );
  }
}
