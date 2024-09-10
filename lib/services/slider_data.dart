import 'package:flutter_intern_task/models/category_model.dart';
import 'package:flutter_intern_task/models/slider_model.dart';

List<sliderModel> getSliders(){
  List<sliderModel> slider = [];
  sliderModel categoryModel = new sliderModel();

  categoryModel.image = "images/health.jpg";
  categoryModel.name="Health is important for everyone";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.image = "images/business.jpg";
  categoryModel.name="Business is important for everyone";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.image = "images/sports.jpg";
  categoryModel.name="Sports is important for everyone";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  categoryModel.image = "images/entertainment.png";
  categoryModel.name="Entertainment is important for everyone";
  slider.add(categoryModel);
  categoryModel = new sliderModel();

  return slider;
}