import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class NavigatorList extends StatelessWidget {
  final List navigatorlist;
  NavigatorList(this.navigatorlist);

  @override
  Widget build(BuildContext context) {
    if (navigatorlist.length > 10) {
      navigatorlist.removeRange(10, navigatorlist.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorlist.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(
            item['mallCategoryName'],
          ),
        ],
      ),
    );
  }
}
