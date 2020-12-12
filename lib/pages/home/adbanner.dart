import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  final String adbannerpicture;
  AdBanner(this.adbannerpicture);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adbannerpicture),
    );
  }
}
