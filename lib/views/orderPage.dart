import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoop_app/model/ordersModel.dart';
import 'package:shoop_app/model/productmodel.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    getOrders();
    // TODO: implement initState
    super.initState();
  }

  void getOrders() async {
    String url = "https://node-server-ymb5.onrender.com/order";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // var jsonResponse = jsonDecode(response.body);

      setState(() {
        orders = ordersFromJson(response.body);
      });
      print('sucess: $orders');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List<Orders> orders = [];
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        // setState(() {
        //   total = total + orders[index]["price"];
        // });

        var order = orders[index];
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
                              title: Text(order.items[index].name),
                            );
                          },
                          itemCount: order!.items.length,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total: ${orders[index].total} ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  ),
                );
              },
            );
          },
          title: Text(orders![index].id),
          subtitle: Text("Placed at: ${orders![index].datetime}"),
        );
      },
    ));
  }
}
