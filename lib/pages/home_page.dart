import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import './home/swiper.dart';
import './home/navigator.dart';
import './home/adbanner.dart';
import './home/leaderphone.dart';
import './home/recommend.dart';
import './home/floor.dart';
import './home/hot.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshIndicatorState> _globalKey =
      new GlobalKey<RefreshIndicatorState>();
  bool get wantKeepAlive => true;
  String homePageContent = '正在获取数据';
  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
      print(val);
    });
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活'),
        ),
        body: FutureBuilder(
          future: request('homePageContext', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperlist = (data['data']['slides'] as List).cast();
              List<Map> navigatorlist =
                  (data['data']['category'] as List).cast();
              String adbanner =
                  (data['data']['advertesPicture']['PICTURE_ADDRESS']);
              String leaderimage = (data['data']['shopInfo']['leaderImage']);
              String leaderphone = (data['data']['shopInfo']['leaderPhone']);
              List<Map> recommendlist =
                  (data['data']['recommend'] as List).cast();
              String floortitle1 =
                  (data['data']['floor1Pic']['PICTURE_ADDRESS']);
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              String floortitle2 =
                  (data['data']['floor2Pic']['PICTURE_ADDRESS']);
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              String floortitle3 =
                  (data['data']['floor3Pic']['PICTURE_ADDRESS']);
              List<Map> floor3 = (data['data']['floor3'] as List).cast();
              return EasyRefresh(
                footer: ClassicalFooter(
                  key: _globalKey,
                  loadText: '拉动加载',
                  loadReadyText: '释放加载',
                  loadingText: '正在加载...',
                  loadedText: "加载完成",
                  loadFailedText: '加载失败',
                  noMoreText: '没有更多数据',
                  infoText: '更新于 %T',
                  infoColor: Color(0xffd5d5d5),
                  textColor: Color(0xffd5d5d5),
                  enableHapticFeedback: true,
                ),
                child: ListView(
                  children: [
                    SwiperDiy(swiperlist),
                    NavigatorList(navigatorlist),
                    AdBanner(adbanner),
                    LeaderPhone(leaderimage, leaderphone),
                    Recommend(recommendlist),
                    FloorTitle(floortitle1),
                    FloorGoods(floor1),
                    FloorTitle(floortitle2),
                    FloorGoods(floor2),
                    FloorTitle(floortitle3),
                    FloorGoods(floor3),
                    HotGoods(),
                  ],
                ),
                onLoad: () async {
                  print('加载中。。。。。。。。。。');
                  var formData = {'page': page};
                  request('homePageBelowConten', formData: formData)
                      .then((val) {
                    var data = json.decode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中。。。。。。。。。。'),
              );
            }
          },
        ));
  }
}
