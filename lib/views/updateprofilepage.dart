import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Updateprofilepage extends StatefulWidget {
  String userid;
  Updateprofilepage({super.key, required this.userid});

  @override
  State<Updateprofilepage> createState() => _UpdateprofilepageState();
}

class _UpdateprofilepageState extends State<Updateprofilepage> {
  var nameController = TextEditingController();

  void updateUser() async {
    try {
      String url = "http://localhost:3000/user/${widget.userid}";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({"username": nameController.text});
      var response =
          await http.put(body: body, headers: headers, Uri.parse(url));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          ElevatedButton(
              onPressed: () {
                updateUser();
              },
              child: Text("update"))
        ],
      ),
    );
  }
}
