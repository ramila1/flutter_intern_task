import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/models/article_model.dart';
import 'package:flutter_intern_task/models/category_model.dart';
import 'package:flutter_intern_task/models/slider_model.dart';
import 'package:flutter_intern_task/pages/all_news.dart';
import 'package:flutter_intern_task/pages/search_categories.dart';
import 'package:flutter_intern_task/services/data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_intern_task/services/news.dart';
import 'package:flutter_intern_task/services/slider_data.dart';
import 'blog_tile.dart';
import 'categories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() =>
      _HomeState(); // Creates the state for this widget
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = []; // List to hold all categories
  List<CategoryModel> filteredCategories =
      []; // List to hold filtered categories based on search
  List<sliderModel> sliders = []; // List to hold slider data
  List<ArticleModel> articles = []; // List to hold articles

  bool _loading = true; // Flag to indicate if data is still loading
  bool _noCategoryFound =
      false; // Flag to indicate if no categories were found during search

  int activeIndex = 0; // Index of the currently active slider item
  final TextEditingController _searchController =
      TextEditingController(); // Controller for the search input

  @override
  void initState() {
    super.initState();
    categories = getCategories(); // Initialize the categories list
    filteredCategories = []; // Initialize as empty
    getSlider(); // Fetch slider data
    getNews(); // Fetch news articles
  }

  // Fetches news articles and updates the state.
  getNews() async {
    News newsclass = News(); // Create an instance of the News service
    await newsclass.getNews(); // Fetch news articles
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  // Fetches slider data and updates the state.
  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  // Handles the search functionality by filtering categories based on the search query.
  void _handleSearch() {
    String query = _searchController.text
        .toLowerCase(); // Convert search query to lowercase
    setState(() {
      if (query.isEmpty) {
        filteredCategories = []; // Clear filtered categories if search is empty
        _noCategoryFound = false; // Reset no category found flag
      } else {
        filteredCategories = categories.where((category) {
          return category.categoryName != null &&
              category.categoryName!
                  .toLowerCase()
                  .startsWith(query); // Filter categories based on search query
        }).toList();
        _noCategoryFound =
            filteredCategories.isEmpty; // Update no category found flag
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text(
              "24x7",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0, // No elevation for the app bar
      ),
      body: _loading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while data is being fetched
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            // Controller for the search input
                            onChanged: (value) => _handleSearch(),
                            // Call search handler on input change
                            decoration: InputDecoration(
                              hintText: 'Search Categories',
                              // Placeholder text for the search input
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Display filtered categories
                  if (_searchController.text.isNotEmpty) ...[
                    if (_noCategoryFound) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "No such category found",
                            // Message when no categories are found
                            style: TextStyle(color: Colors.red, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.only(left: 20.0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                return SearchCategories(
                                  categoryName:
                                      filteredCategories[index].categoryName,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ],
                  // Categories List
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // Horizontal scroll for categories list
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Categories(
                          image: categories[index].image,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // Breaking News
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breaking News!!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'PTSerif',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllNews(news: "Breaking"),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Carousel Slider
                  CarouselSlider.builder(
                    itemCount: sliders.length,
                    itemBuilder: (context, index, realIndex) {
                      String? res = sliders[index].urlToImage;
                      String? res1 = sliders[index].title;
                      return buildImage(res!, index,
                          res1!); // Build image for each slider item
                    },
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      // Enable automatic sliding
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex =
                              index; // Update active index on page change
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Center(child: buildIndicator()),
                  SizedBox(height: 30.0),
                  // Trending News
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending News!!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'PTSerif',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllNews(news: "Trending"),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Articles List
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          url: articles[index].url!,
                          desc: articles[index].description!,
                          imageUrl: articles[index].urlToImage!,
                          title: articles[index].title!,
                        ); // Display each article using BlogTile widget
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Builds an image widget for the carousel slider.
  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(left: 10.0),
              margin: EdgeInsets.only(top: 150.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  name, // Title of the slider item
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // Builds the page indicator for the carousel slider.
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex, // Current active index of the carousel slider
        count: sliders.length, // Total number of slider items
        effect: SlideEffect(
          dotWidth: 15,
          dotHeight: 15,
          activeDotColor: Colors.red,
        ),
      );
}
