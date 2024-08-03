import 'dart:convert';
import 'dart:io';
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

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future<String?> _convertImageToBase64(XFile image) async {
    try {
      final bytes = await File(image.path).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      print("Error converting image to base64: $e");
      return null;
    }
  }

  void registerUser() async {
    try {
      String? base64Image;
      if (_imageFile != null) {
        base64Image = await _convertImageToBase64(_imageFile!);
      }

      String url = "http://localhost:3000/register";
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      final body = jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "image": base64Image ?? ''
      });

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 201) {
        print('User registered successfully');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ));
      } else {
        print('Failed to register user: ${response.body}');
      }
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
            "SignUp",
            style: TextStyle(fontSize: 40),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Pick Image"),
          ),
          ElevatedButton(
            onPressed: registerUser,
            child: Text("SignUp"),
          ),
        ],
      ),
    );
  }
}
