import 'package:order_food/data/models/product.dart';

class Cart {
  String? id;
  String? name;
  int? quantity;
  bool? isExist;
  int? price;
  String? img;
  String? time;
  Products? product;

  Cart({
    this.id,
    this.name,
    this.quantity,
    required this.isExist,
    this.price,
    this.img,
    this.time,
    this.product,
  });

  Cart.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    price = json["price"];
    img = json["image"];
    quantity = json["quantity"];
    isExist = json["isExist"];
    time = json["time"];
    product = Products.fromJson(json['product']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "price": price,
      "image": img,
      "quantity": quantity,
      "isExists": isExist,
      "time": time,
      "product": product!.toJson()
    };
  }
}