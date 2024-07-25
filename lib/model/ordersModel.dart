// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  String id;
  List<Item> items;
  String datetime;
  int total;
  int v;

  Orders({
    required this.id,
    required this.items,
    required this.datetime,
    required this.total,
    required this.v,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["_id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        datetime: json["datetime"],
        total: json["total"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "datetime": datetime,
        "total": total,
        "__v": v,
      };
}

class Item {
  String id;
  String name;
  String description;
  int price;
  String category;
  String image;
  int v;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.v,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        image: json["image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "image": image,
        "__v": v,
      };
}
