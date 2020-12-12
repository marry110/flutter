import 'package:app20/provide/child_category_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../../model/category_list_model.dart';
import 'dart:convert';
import '../../service/service_method.dart';
import 'package:provide/provide.dart';
import '../../provide/category_list_provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  GlobalKey<RefreshIndicatorState> _globalKey =
      new GlobalKey<RefreshIndicatorState>();
  var scrollController = new ScrollController();
  // List list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategoryProvide>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：$e');
        }
        if (data.goodslist.length > 0) {
          return Container(
            width: ScreenUtil().setWidth(570),
            height: ScreenUtil().setHeight(1000),
            child: EasyRefresh(
              footer: ClassicalFooter(
                key: _globalKey,
                loadText: '拉动加载',
                loadReadyText: '释放加载',
                loadingText: '正在加载...',
                loadedText: "加载完成",
                loadFailedText: '加载失败',
                noMoreText:
                    Provide.value<ChildCategoryProvide>(context).noMoreText,
                infoText: '更新于 %T',
                infoColor: Color(0xffd5d5d5),
                textColor: Color(0xffd5d5d5),
                enableHapticFeedback: true,
              ),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodslist.length,
                  itemBuilder: (context, index) {
                    return _listWidget(data.goodslist, index);
                  }),
              onLoad: () async {
                print('没有更多了.......');
                _getMoreList();
              },
            ),
          );
        } else {
          return Text('暂时没有数据');
        }
      },
    );
  }

  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(
        newList[index].image,
      ),
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: [
          Text(
            '价格:${newList[index].presentPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
              color: Colors.pink,
            ),
          ),
          Text(
            '${newList[index].oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: [
            _goodsImage(newList, index),
            Column(
              children: [
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getMoreList() async {
    Provide.value<ChildCategoryProvide>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': Provide.value<ChildCategoryProvide>(context).subId,
      'page': Provide.value<ChildCategoryProvide>(context).page,
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
        Provide.value<ChildCategoryProvide>(context)
            .changeNoMoreText('no more text');
        Fluttertoast.showToast(
          msg: '已经到底了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(goodslist.data);
      }
    });
  }
}
