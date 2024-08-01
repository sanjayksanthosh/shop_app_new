import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {
  String token = "";
  setToken(String userToken) {
    token = userToken;
    notifyListeners();
    print(token);
  }
}
