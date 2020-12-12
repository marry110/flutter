import 'package:app20/provide/category_list_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../../model/category_all_model.dart';
import 'dart:convert';
import '../../service/service_method.dart';
import 'package:provide/provide.dart';
import '../../provide/child_category_provide.dart';
import '../../model/category_list_model.dart';

class CategoryLeft extends StatefulWidget {
  CategoryLeft({Key key}) : super(key: key);

  @override
  _CategoryLeftState createState() => _CategoryLeftState();
}

class _CategoryLeftState extends State<CategoryLeft> {
  List list = [];
  var listIndex = 0;
  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInwellWidget(index);
        },
      ),
    );
  }

  Widget _leftInwellWidget(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategoryProvide>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      print('分类数据>>>>>>>>>>>>>>>>>$data');
      CategoryModel category = CategoryModel.fromJson(data);
      // list.data.forEach((item) => print(item.mallCategoryName));
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategoryProvide>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
      'page': 1,
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print('分类list数据<<<<<<<<<<<<<<<<<<<<<<<$data');
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(data);
      print('分类数据。。。。。。。。。。。。。。${goodslist.data[0].goodsName}');
      // setState(() {
      //   list = goodslist.data;
      // });
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodslist.data);
    });
  }
}
