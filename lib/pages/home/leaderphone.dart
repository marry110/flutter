import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderimage;
  final String leaderphone;
  LeaderPhone(this.leaderimage, this.leaderphone);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderimage),
      ),
    );
  }

  void _launchURL() async {
    // String url = 'tel:' + leaderphone;
    const url = 'https://www.jspang.com/detailed?id=53#toc251';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }
}
