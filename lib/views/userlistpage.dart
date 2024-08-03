import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoop_app/views/updateprofilepage.dart';

class Userlistpage extends StatefulWidget {
  const Userlistpage({super.key});

  @override
  State<Userlistpage> createState() => _UserlistpageState();
}

class _UserlistpageState extends State<Userlistpage> {
  List Users = [];

  void getUsers() async {
    String url = "http://localhost:3000/users";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        Users = jsonResponse;
      });
      print('sucess: $Users');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void deleteuser(String id) async {
    String url = "http://localhost:3000/user/$id";

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      print('Success: $jsonResponse');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    getUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.builder(
        itemCount: Users.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://localhost:3000/${Users[index]["image"]}"),
                  radius: 20,
                ),
                Text(Users[index]["username"]),
                Text(Users[index]["email"]),
                Text(Users[index]["phone"]),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Updateprofilepage(
                                User: Users[index],
                              );
                            },
                          ));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          deleteuser(Users[index]["_id"]);
                          getUsers();
                        },
                        icon: Icon(Icons.delete_forever))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
