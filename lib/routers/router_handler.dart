import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/detail_page.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('index detail $goodsId');
  return DetailsPage(goodsId);
});
