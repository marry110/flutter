import 'package:flutter/material.dart';
import '../model/category_all_model.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; //大类ID
  String subId = ''; //子类ID
  String noMoreText = '';
  int page = 1;
//大类切换效果
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    categoryId = id;
    childIndex = 0;
    BxMallSubDto all = new BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);

    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
