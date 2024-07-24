import 'package:flutter/material.dart';
import 'package:shoop_app/model/productmodel.dart';

class Itemprovide extends ChangeNotifier {
  List products = [];
  getitems(var items) {
    products = items;
    notifyListeners();
  }
}
