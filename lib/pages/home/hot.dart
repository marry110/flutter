import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import '../../routers/application.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  int page = 1;
  List<Map> hotGoodsList = [];
  String homePageContenthot = '正在获取数据hot';
  @override
  void initState() {
    request('homePageBelowConten', formData: 1).then((val) {
      setState(() {
        homePageContenthot = val.toString();
      });
      print(val);
      _getHotGoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _hotarealist(),
    );
  }

  Widget hottitle() {
    return Container(
      margin: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: Text('火爆专区'),
    );
  }

  Widget _hotwraplist() {
    if (hotGoodsList.length != 0) {
      List<Widget> listwidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, "/detail?id=${val['goodsId']}");
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: [
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(372),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '￥${val['mallPrice']}',
                    ),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listwidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotarealist() {
    return Container(
      child: Column(
        children: [
          hottitle(),
          _hotwraplist(),
        ],
      ),
    );
  }

  void _getHotGoods() {
    var formData = {'page': page};
    request('homePageBelowConten', formData: formData).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }
}
