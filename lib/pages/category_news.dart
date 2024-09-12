import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/models/show_category.dart';
import 'package:flutter_intern_task/pages/article_view.dart';
import 'package:flutter_intern_task/services/show_category_news.dart';

// The CategoryNews widget fetches and displays news articles for a given category.
// The category is specified by the name parameter.
class CategoryNews extends StatefulWidget {
  final String name;

  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = []; // List to hold news categories
  bool _loading = true; // Flag to indicate if data is still loading
  String _errorMessage = ''; // To store error messages

  @override
  void initState() {
    super.initState();
    getNews(); // Fetch news data when the widget is initialized
  }

  // Fetches news data based on the category name and updates the state.
  Future<void> getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    try {
      await showCategoryNews.getCategoriesNews(
          widget.name.toLowerCase()); // Fetch news for the specified category
      if (showCategoryNews.categories != null) {
        setState(() {
          categories =
              showCategoryNews.categories; // Update the categories list
          _loading = false; // Set loading flag to false
        });
      } else {
        setState(() {
          _errorMessage = 'No news found';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load news';
        _loading = false;
      });
      print(e); // Print error to console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name, // Display the category name in the app bar
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                  strokeWidth:
                      1.0)) // Smaller loading circle while data is loading
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: categories.length, // Number of items to display
                    itemBuilder: (context, index) {
                      return ShowCategory(
                        image: categories[index].urlToImage ?? '',
                        desc: categories[index].description ?? 'No description',
                        title: categories[index].title ?? 'No title',
                        url: categories[index].url ?? '',
                      );
                    },
                  ),
                ),
    );
  }
}

// The ShowCategory widget displays details about a "news" item, including
// the image, description, title, and a clickable link to more details.
class ShowCategory extends StatelessWidget {
  final String image;
  final String desc;
  final String title;
  final String url;

  ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ArticleView(blogUrl: url)), // Navigate to article view page
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('URL is not available')),
          );
        }
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: image.isNotEmpty ? image : 'images/placeholder.jpg',
                // Use a default placeholder image if the image URL is empty
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('images/placeholder.jpg', fit: BoxFit.cover),
                // Use a local placeholder image if there is an error loading the network image
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
