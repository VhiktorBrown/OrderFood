class Cart {
  String? id;
  String? name;
  int? quantity;
  bool? isExist;
  int? price;
  String? img;
  String? time;

  Cart({
    this.id,
    this.name,
    this.quantity,
    required this.isExist,
    this.price,
    this.img,
    this.time
  });

  Cart.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    name = json["name"];
    price = json["price"];
    img = json["image"];
    quantity = json["quantity"];
    isExist = json["isExist"];
    time = json["time"];
  }
}