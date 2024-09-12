import 'package:flutter/material.dart';

import 'category_news.dart';

class SearchCategories extends StatelessWidget {
  final categoryName;

  SearchCategories({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(name: categoryName),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
