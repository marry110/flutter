import 'package:flutter/material.dart';

class CounterProvide with ChangeNotifier {
  var value = 0;
  increment() {
    value++;
    notifyListeners();
  }
}
