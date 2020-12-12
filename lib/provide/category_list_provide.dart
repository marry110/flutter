import 'package:flutter/material.dart';
import '../model/category_list_model.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodslist = [];
  getGoodsList(List<CategoryListData> list) {
    goodslist = list;
    notifyListeners();
  }

  getMoreList(List<CategoryListData> list) {
    goodslist.addAll(list);
    notifyListeners();
  }
}
