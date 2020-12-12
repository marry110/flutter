import 'package:flutter/material.dart';
import './category/categoryleft.dart';
import './category/categoryright.dart';
import './category/categorylist.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类页面'),
      ),
      body: Container(
        child: Row(
          children: [
            CategoryLeft(),
            SingleChildScrollView(
              child: Column(
                children: [
                  CategoryRight(),
                  CategoryList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
