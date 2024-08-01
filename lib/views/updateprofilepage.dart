import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Updateprofilepage extends StatefulWidget {
  var User;

  Updateprofilepage({super.key, required this.User});

  @override
  State<Updateprofilepage> createState() => _UpdateprofilepageState();
}

class _UpdateprofilepageState extends State<Updateprofilepage> {
  void updateUser(String name, String phone) async {
    try {
      String url = "http://localhost:3000/user/${widget.User["_id"]}";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({"username": name, "phone": phone});
      var response =
          await http.put(body: body, headers: headers, Uri.parse(url));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: widget.User["username"]);
    var phoneController = TextEditingController(text: widget.User["phone"]);

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: phoneController,
          ),
          ElevatedButton(
              onPressed: () {
                updateUser(nameController.text, phoneController.text);
              },
              child: Text("update"))
        ],
      ),
    );
  }
}
