import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shoop_app/views/homepage.dart';

class Registerpage extends StatefulWidget {
  Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var emailController = TextEditingController();
  var nameController = TextEditingController();

  void registerUser() async {
    try {
      String url = "http://localhost:3000/register";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "image": _imageFile!.path
      });
      var response =
          await http.post(body: body, headers: headers, Uri.parse(url));
      print(response.body);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Homepage();
        },
      ));
    } catch (e) {
      print(e);
    }
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
    print(_imageFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "SignUp",
            style: TextStyle(fontSize: 40),
          ),
          TextField(
            controller: usernameController,
          ),
          TextField(
            controller: passwordController,
          ),
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: phoneController,
          ),
          TextField(
            controller: emailController,
          ),
          ElevatedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text("pick image")),
          ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: Text("SignUp"))
        ],
      ),
    );
  }
}
