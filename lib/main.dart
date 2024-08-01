import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoop_app/providers/cartProvider.dart';
import 'package:shoop_app/providers/itemProvide.dart';
import 'package:shoop_app/providers/userProvider.dart';
import 'package:shoop_app/views/homepage.dart';
import 'package:shoop_app/views/loginpage.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Itemprovide()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Userprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loginpage(),
    );
  }
}
