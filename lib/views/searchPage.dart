import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoop_app/model/productmodel.dart';
import 'package:shoop_app/providers/cartProvider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> items = [];
  // TextEditingController searchController = TextEditingController();

  void searchproduct(String name) async {
    String url =
        "https://node-server-ymb5.onrender.com/items/search?name=$name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // var jsonResponse = jsonDecode(response.body);
      setState(() {
        items = itemsFromJson(response.body);
      });
      print('sucess: $items');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              // controller: TextEditingController(),
              onChanged: (value) {
                searchproduct(value);
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].name),
                    subtitle: Text("Price:${items[index].price}"),
                    trailing: ElevatedButton(
                      child: Text("Add"),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(items[index]);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
