import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoop_app/model/productmodel.dart';
import 'package:shoop_app/providers/itemProvide.dart';
import 'package:shoop_app/views/cartPage.dart';
import 'package:shoop_app/views/categoryPage.dart';
import 'package:shoop_app/views/orderPage.dart';
import 'package:shoop_app/views/profilePage.dart';
import 'package:shoop_app/widgets/product_card.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  List pages = [Home(), Categorypage(), Cartpage(), OrderPage()];

  List Products = [];

  void getProducts() async {
    String url = "https://node-server-ymb5.onrender.com/items";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // var jsonResponse = jsonDecode(response.body);
      setState(() {
        Products = itemsFromJson(response.body);
      });
      print('sucess: $Products');

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final providerItems = Provider.of<Itemprovide>(context, listen: false);
        providerItems.getitems(Products);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    getProducts();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Profilepage();
                  },
                ));
              },
              icon: Icon(Icons.account_circle),
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.green,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
                color: Colors.green,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.green,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.green,
              ),
              label: 'Orders',
            ),
          ],
        ),
        body: pages[_currentIndex]);
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<Itemprovide>(builder: (context, item, _) {
            return item.products == null
                ? Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 5,
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    padding: EdgeInsets.all(8.0),
                    itemCount: item.products.length, // total number of items,

                    itemBuilder: (context, index) {
                      return Productcard(product: item.products[index]);
                    },
                  );
          }),
        )
      ],
    );
  }
}
