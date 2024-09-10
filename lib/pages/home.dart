import 'package:flutter/material.dart';
import 'package:flutter_intern_task/models/category_model.dart';
import 'package:flutter_intern_task/services/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories= [];
  @override
  void initState(){
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("News"),Text("24x7",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(child: ListView.builder(
              shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context,index){
              return Categories(
                image:categories[index].image,
                categoryName: categories[index].categoryName,
              );
            }),
            )

          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final image, categoryName;
  Categories({this.categoryName,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            image,
            width:120,
            height: 60,
          )
        ],
      ),
    );
  }
}

