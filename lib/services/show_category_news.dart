import 'dart:convert';

import 'package:flutter_intern_task/models/show_category.dart';

import 'package:http/http.dart' as http;

// Class to fetch news based on categories
class ShowCategoryNews {
  List<ShowCategoryModel> categories =
      []; // List to hold fetched category-specific news articles

  // Method to fetch news for a specific category
  // Takes a category name as a parameter to filter the news
  Future<void> getCategoriesNews(String category) async {
    // Define the API URL with the given category
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=da7b5092b4794a9b91479004b87f57d6";

    // Make an HTTP GET request to fetch the news articles based on the category
    var response = await http.get(Uri.parse(url));

    // Decode the JSON response
    var jsonData = jsonDecode(response.body);

    // Check if the API status is 'ok'
    if (jsonData['status'] == 'ok') {
      // Loop through each article in the 'articles' array
      jsonData["articles"].forEach((element) {
        // Check if the article has both an image URL and a description
        if (element['urlToImage'] != null && element['description'] != null) {
          // Create a ShowCategoryModel instance with the article data
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            // Title of the article
            description: element["description"],
            // Article description
            url: element["url"],
            // URL to the article
            urlToImage: element["urlToImage"],
            // Image URL for the article
            content: element["content"],
            // Article content
            author: element["author"], // Author of the article
          );
          // Add the article to the categories list
          categories.add(categoryModel);
        }
      });
    }
  }
}
