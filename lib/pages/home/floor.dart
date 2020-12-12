import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class FloorTitle extends StatelessWidget {
  final String floortitle;
  FloorTitle(this.floortitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(floortitle),
    );
  }
}

class FloorGoods extends StatelessWidget {
  final List floorgoodslist;
  FloorGoods(this.floorgoodslist);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _firstrow(context),
        _otherrow(context),
      ],
    );
  }

  Widget _flooritem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(372),
      child: InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstrow(context) {
    return Row(
      children: [
        _flooritem(context, floorgoodslist[0]),
        Column(
          children: [
            _flooritem(context, floorgoodslist[1]),
            _flooritem(context, floorgoodslist[2]),
          ],
        )
      ],
    );
  }

  Widget _otherrow(context) {
    return Row(
      children: [
        _flooritem(context, floorgoodslist[3]),
        _flooritem(context, floorgoodslist[4]),
      ],
    );
  }
}
