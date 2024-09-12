import 'package:flutter_intern_task/models/category_model.dart';

// Returns a list of CategoryModel instances
List<CategoryModel> getCategories() {
  List<CategoryModel> category =
      []; // Initialize an empty list of CategoryModel
  CategoryModel categoryModel =
      new CategoryModel(); // Create a new instance of CategoryModel

  // Define the "Health" category
  categoryModel.categoryName = "Health";
  categoryModel.image = "images/health.jpg";
  category.add(categoryModel); // Add the category to the list
  categoryModel =
      new CategoryModel(); // Create a new instance for the next category

  // Define the "Business" category
  categoryModel.categoryName = "Business";
  categoryModel.image = "images/business.jpg";
  category.add(categoryModel); // Add the category to the list
  categoryModel =
      new CategoryModel(); // Create a new instance for the next category

  // Define the "Sports" category
  categoryModel.categoryName = "Sports";
  categoryModel.image = "images/sports.jpg";
  category.add(categoryModel); // Add the category to the list
  categoryModel =
      new CategoryModel(); // Create a new instance for the next category

  // Define the "Entertainment" category
  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "images/entertainment.png";
  category.add(categoryModel); // Add the category to the list
  categoryModel =
      new CategoryModel(); // Create a new instance for the next category

  return category; // Return the list of categories
}
