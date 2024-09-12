# flutter_intern_task

A news app Flutter project.

## Getting Started

Home Page - lib/pages/home.dart

Landing Page - lib/pages/landing.dart

Different Categories below the search bar - lib/pages/categories.dart

Display Category wise news- lib/pages/category_news.dart

When click on the view all then run- lib/pages/allnews.dart

When click on the Article then display the whole view of the article - lib/pages/article_view.dart

Display about the article below the Trending news- lib/pages/blog_tile.dart

go to search result category - search_categories.dart

models:

ArticleModel class and properties are defined: lib/models/article_model.dart

CategoryModel class contains properties to store details about a category: lib/models/category_model.dart

ShowCategoryModel class contains properties to store various details about a category item: lib/models/show_category.dart

sliderModel class contains properties to store various details about a slider item: lib/models/slider_model.dart


services:

Define different categories and returns a list of CategoryModel instances and categories: lib/services/data.dart

Fetch API for trending news: lib/services/news.dart

Class to fetch news based on categories: lib/services/show_category_news.dart

Class to fetch slider data: lib/services/slider_data.dart

Call the landing page- main.dart



Unit test of article_model:test/article_model_test.dart


category images and other images are stored in images folder


