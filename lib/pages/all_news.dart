import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/models/article_model.dart';
import 'package:flutter_intern_task/models/slider_model.dart';
import '../services/news.dart';
import '../services/slider_data.dart';
import 'article_view.dart';

// The AllNews widget fetches and displays news articles and slider items
// based on the category passed through the "news" parameter.

class AllNews extends StatefulWidget {
  final String news;

  AllNews({required this.news}); // Constructor to initialize the news parameter

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = []; // List to hold slider items
  List<ArticleModel> articles = []; // List to hold news articles
  bool isLoading = true; // Flag to indicate if data is still loading
  String errorMessage = ''; // To store error messages

  @override
  void initState() {
    super.initState();
    getSlider(); // Fetch slider data when the widget is initialized
    getNews(); // Fetch news articles when the widget is initialized
  }

  getNews() async {
    try {
      News newsclass = News();
      await newsclass.getNews(); // Fetch news articles
      setState(() {
        articles = newsclass.news;
        isLoading = false; // Set loading flag to false
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch news'; // Set error message
        isLoading = false;
      });
    }
  }

  getSlider() async {
    try {
      Sliders slider = Sliders();
      await slider.getSlider();
      setState(() {
        sliders = slider.sliders;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch slider data';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News", // Display the category name in the app bar
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: widget.news == "Breaking"
                        ? sliders
                            .length // Display slider items if category is "Breaking"
                        : articles.length, // Display articles otherwise
                    itemBuilder: (context, index) {
                      return AllNewsSection(
                        image: widget.news == "Breaking"
                            ? sliders[index].urlToImage ?? ''
                            : articles[index].urlToImage ?? '',
                        desc: widget.news == "Breaking"
                            ? sliders[index].description ??
                                'No description available'
                            : articles[index].description ??
                                'No description available',
                        title: widget.news == "Breaking"
                            ? sliders[index].title ?? 'No title'
                            : articles[index].title ?? 'No title',
                        url: widget.news == "Breaking"
                            ? sliders[index].url ?? ''
                            : articles[index].url ?? '',
                      );
                    },
                  ),
                ),
    );
  }
}

// The AllNewsSection widget shows details about a news or slider item, including
// the image, description, title, and a clickable link to more details.
class AllNewsSection extends StatelessWidget {
  final String image;
  final String desc;
  final String title;
  final String url;

  AllNewsSection({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    bool isValidImage = image.isNotEmpty;
    return GestureDetector(
      onTap: () {
        if (url.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleView(blogUrl: url)));
        }
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: isValidImage
                  ? CachedNetworkImage(
                      imageUrl: image,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.grey,
                      child: Icon(Icons.broken_image),
                    ),
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
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
