import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoop_app/model/productmodel.dart';
import 'package:shoop_app/providers/cartProvider.dart';
import 'package:http/http.dart' as http;
import 'package:shoop_app/providers/itemProvide.dart';

class Cartpage extends StatefulWidget {
  Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  int totalAmount = 0;

  void placeOrder() async {
    try {
      String url = "https://node-server-ymb5.onrender.com/order";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({
        "items": Provider.of<CartProvider>(context, listen: false).cartItems,
        "datetime": DateTime.now().toString(),
        "total": Provider.of<CartProvider>(context, listen: false).totalAmount
      });
      var response =
          await http.post(body: body, headers: headers, Uri.parse(url));
      print(response.body);
    } catch (e) {
      print(e);
    }
    // if (response.statusCode == 201) {
    //   // var jsonResponse = jsonDecode(response.body);

    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     final providerItems = Provider.of<Itemprovide>(context, listen: false);
    //   });
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
              child: Text("clear all"),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)),
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(builder: (context, item, _) {
              item.totalsum();
              return item.cartItems.isEmpty
                  ? Center(child: Text("Cart is empty"))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        Product cartItems = item.cartItems[index];
                        return ListTile(
                          title: Text(cartItems.name),
                          trailing: Text(cartItems.price.toString()),
                        );
                      },
                      itemCount: item.cartItems.length,
                    );
            }),
          ),
          Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                placeOrder();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("CheckOut"),
                  SizedBox(
                    width: 30,
                  ),
                  Consumer<CartProvider>(builder: (context, item, _) {
                    return Text(item.totalAmount.toString());
                  })
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
