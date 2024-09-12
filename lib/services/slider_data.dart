import 'dart:convert';

import 'package:flutter_intern_task/models/slider_model.dart';
import 'package:http/http.dart' as http;

// Class to fetch slider data
class Sliders {
  List<sliderModel> sliders = []; // List to hold fetched slider articles

  // Method to fetch slider articles from the API
  Future<void> getSlider() async {
    // Define the API URL for fetching top headlines from TechCrunch
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=da7b5092b4794a9b91479004b87f57d6";

    // Make an HTTP GET request to fetch the slider data
    var response = await http.get(Uri.parse(url));

    // Decode the JSON response
    var jsonData = jsonDecode(response.body);

    // Check if the API status is 'ok'
    if (jsonData['status'] == 'ok') {
      // Loop through each article in the 'articles' array
      jsonData["articles"].forEach((element) {
        // Check if the article has both an image URL and a description
        if (element['urlToImage'] != null && element['description'] != null) {
          // Create a sliderModel instance with the article data
          sliderModel slidermodel = sliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          // Add the article to the sliders list
          sliders.add(slidermodel);
        }
      });
    }
  }
}
