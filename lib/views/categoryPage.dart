import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoop_app/model/categoryModel.dart';
import 'package:shoop_app/views/categoryItemsPage.dart';

class Categorypage extends StatefulWidget {
  Categorypage({super.key});

  @override
  State<Categorypage> createState() => _CategorypageState();
}

class _CategorypageState extends State<Categorypage> {
  List Categories = [];

  getCategories() async {
    Uri url = Uri.parse("https://node-server-ymb5.onrender.com/category");
    var response = await http.get(url);
    var data = categoryFromJson(response.body);
    setState(() {
      Categories = data;
    });
  }

  @override
  void initState() {
    getCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Categoryitemspage(
                  categoryData: Categories[index],
                );
              },
            ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)),
            child: Text(
              Categories[index].name,
              style: TextStyle(fontSize: 25),
            ),
          ),
        );
      },
      itemCount: Categories.length,
    );
  }
}
