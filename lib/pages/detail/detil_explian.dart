import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DetailExplian extends StatelessWidget {
  const DetailExplian({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}
