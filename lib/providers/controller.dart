import 'package:flutter/material.dart';

import '../models/item.dart';

class Controller extends ChangeNotifier {
  List<Item> _data = [];

  int lastValueCheck = 0;

  List<Item> get data {
    return _data;
  }

  init() {
    final arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    final randomArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    randomArr.shuffle();

    for (int i = 0; i < arr.length; i++) {
      _data.add(Item(arr[i], randomArr[i], true, false));
    }
  }

  void start() {
    final temps = [..._data];

    _data = temps.map((val) {
      val.isChecked = false;
      return val;
    }).toList();

    notifyListeners();
  }

  void checkValue(int value) {
    final dt = _data.firstWhere((val) => val.value == value);
    // final unCheckdt = data.firstWhere((val) => !val.isChecked);

    dt.isChecked = true;

    if ((lastValueCheck + 1) != dt.randomValue) {
      dt.isError = true;
    } else {
      lastValueCheck = lastValueCheck + 1;
    }

    // if ((dt.randomValue != unCheckdt.value) && ) {
    //   dt.isError = true;
    // } else {
    //   lastValueCheck = unCheckdt.value;
    // }

    notifyListeners();
  }
}
