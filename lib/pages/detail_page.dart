import 'package:app20/pages/detail/detail_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info_provide.dart';
import './detail/detail_top_area.dart';
import './detail/detil_explian.dart';
import './detail/detail_tabbar.dart';
import './detail/detail_web.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('详情页面'),
      ),
      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    child: ListView(
                      children: [
                        DetailsTopArea(),
                        DetailExplian(),
                        DetailsTabbar(),
                        DetailsWeb(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: DetailsBottom(),
                  )
                ],
              );
            } else {
              return Text('加载中。。。。。。。');
            }
          }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完毕。。。。。。。。';
  }
}
