import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shoop_app/providers/userProvider.dart';
import 'package:shoop_app/views/updateprofilepage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  var user;
  void getCurrentUser() async {
    String url = "http://localhost:3000/user/me";

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<Userprovider>(context, listen: false).token}'
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        user = jsonResponse;
      });
      print('Success: ${user["username"]}');
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
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 70,
              foregroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user["username"],
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  user["email"],
                  style: TextStyle(fontSize: 35),
                ),
                Text(
                  user["phone"],
                  style: TextStyle(fontSize: 35),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Updateprofilepage(User: user);
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                  color: Colors.green,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.output_sharp,
                              color: Colors.green,
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.redAccent)),
                        onPressed: () {
                          deleteuser(user["_id"]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              "Delete Account",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
