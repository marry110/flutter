import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../routers/application.dart';

class SwiperDiy extends StatelessWidget {
  final List swiprelist;
  SwiperDiy(this.swiprelist);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      child: InkWell(
        onTap: () {},
        child: Swiper(
          itemCount: swiprelist.length,
          pagination: SwiperPagination(),
          autoplay: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Application.router.navigateTo(
                    context, "/detail?id=${swiprelist[index]['goodsId']}");
              },
              child: Image.network(
                '${swiprelist[index]['image']}',
                fit: BoxFit.fill,
              ),
            );
          },
        ),
      ),
    );
  }
}
