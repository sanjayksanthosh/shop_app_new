import 'package:flutter/material.dart';
import 'package:shoop_app/model/productmodel.dart';
import 'package:shoop_app/views/product_details_page.dart';

class Productcard extends StatelessWidget {
  Product product;
  Productcard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailsPage(
              product: product,
            );
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .5)),
        height: 100,
        width: 100,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(product.image))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs.${product.price.toString()}",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              product.description,
            )
          ],
        ),
      ),
    );
  }
}
