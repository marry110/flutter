import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counterprovide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<CounterProvide>(
        builder: (context, child, counter) {
          return Text('${counter.value}');
        },
      ),
    );
  }
}
