import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoop_app/providers/userProvider.dart';
import 'package:shoop_app/views/homepage.dart';
import 'package:shoop_app/views/registerpage.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  void loginUser() async {
    try {
      String url = "http://localhost:3000/login";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text
      });
      var response =
          await http.post(body: body, headers: headers, Uri.parse(url));
      var data = jsonDecode(response.body);
      print(data);
      Provider.of<Userprovider>(context, listen: false).setToken(data['token']);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Login",
            style: TextStyle(fontSize: 40),
          ),
          TextField(
            controller: usernameController,
          ),
          TextField(
            controller: passwordController,
          ),
          ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Registerpage();
                  },
                ));
              },
              child: Text("dont have an account SignUp"))
        ],
      ),
    );
  }
}
