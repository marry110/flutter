import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/child_category_provide.dart';
import '../../model/category_all_model.dart';
import '../../provide/category_list_provide.dart';
import '../../model/category_list_model.dart';
import 'dart:convert';
import '../../service/service_method.dart';

class CategoryRight extends StatefulWidget {
  CategoryRight({Key key}) : super(key: key);

  @override
  _CategoryRightState createState() => _CategoryRightState();
}

class _CategoryRightState extends State<CategoryRight> {
  // List list = ['名酒', '宝丰', '北京二锅头', '名酒', '宝丰', '北京二锅头', '名酒', '宝丰', '北京二锅头'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (conext, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInwellWidget(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInwellWidget(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvide>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategoryProvide>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  void _getGoodsList(String categorysubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': categorysubId,
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

      if (goodslist.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodslist.data);
      }
    });
  }
}
