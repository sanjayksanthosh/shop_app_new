import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoop_app/model/productmodel.dart';

class Networkservices {
  Future getProducts() async {
    String url = "http://localhost:3000/items";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List products = itemsFromJson(response.body);
      // var jsonResponse = jsonDecode(response.body);
      return products;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
