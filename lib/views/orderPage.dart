import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List orders = [
    {
      "id": "dau883992-ad2",
      "date": "22/2/6 15:55:52",
      "isPlaced": true,
      "name": "carrot",
      "price": 100
    },
    {
      "id": "lpo89i4-wer",
      "date": "12/23/8 8:75:5",
      "isPlaced": false,
      "name": "battery",
      "price": 200
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        // setState(() {
        //   total = total + orders[index]["price"];
        // });
        return ListTile(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        "Order items",
                        style: TextStyle(fontSize: 30),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(orders[index]["name"]),
                            );
                          },
                          itemCount: orders.length,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total: 300 ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Close"))
                    ],
                  ),
                );
              },
            );
          },
          title: Text(orders[index]["id"]),
          subtitle: Text("Placed at: ${orders[index]["date"]}"),
          trailing: Text(orders[index]["isPlaced"] ? "placed" : "not placed"),
        );
      },
    ));
  }
}
