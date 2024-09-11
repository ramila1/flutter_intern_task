import 'dart:convert';

import 'package:flutter_intern_task/models/show_category.dart';
import 'package:flutter_intern_task/models/slider_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_intern_task/models/show_category.dart';
class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=da7b5092b4794a9b91479004b87f57d6";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if(element['urlToImage']!=null && element['description']!=null){
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}