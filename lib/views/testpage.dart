import 'package:flutter/material.dart';
import 'package:shoop_app/services/networkservices.dart';
import 'package:shoop_app/widgets/product_card.dart';

class Testpage extends StatelessWidget {
  Testpage({super.key});

  var services = Networkservices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: services.getProducts(),
      builder: (context, snapshot) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 4 / 5,
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data.length, // total number of items,

          itemBuilder: (context, index) {
            return Productcard(product: snapshot.data[index]);
          },
        );
      },
    ));
  }
}
