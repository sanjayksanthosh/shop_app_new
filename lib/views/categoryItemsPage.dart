import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoop_app/model/categoryModel.dart';
import 'package:shoop_app/model/productmodel.dart';
import 'package:shoop_app/widgets/product_card.dart';

class Categoryitemspage extends StatefulWidget {
  Category? categoryData;
  Categoryitemspage({super.key, this.categoryData});

  @override
  State<Categoryitemspage> createState() => _CategoryitemspageState();
}

class _CategoryitemspageState extends State<Categoryitemspage> {
  List item = [];
  getCategoryitems() async {
    Uri url = Uri.parse(
        "https://node-server-ymb5.onrender.com/items/category/${widget.categoryData!.categoryId}");
    var response = await http.get(url);
    var data = itemsFromJson(response.body);
    print(widget.categoryData!.categoryId);
    setState(() {
      item = data;
    });
  }

  @override
  void initState() {
    getCategoryitems();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryData!.name),
        ),
        body: Center(
          child: item.isEmpty
              ? Text("no items available")
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 5,
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                  ),
                  padding: EdgeInsets.all(8.0),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Productcard(product: item[index]);
                  },
                ),
        ));
  }
}
