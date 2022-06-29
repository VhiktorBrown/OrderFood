
class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<Products>? _products;
  List<Products>? get products => _products;

  Product({totalSize, typeId, offset, products}){
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json){
    _totalSize = json["total_size"];
    _typeId = json["type_id"];
    _offset = json["offset"];
    if(json["products"] != null){
      _products = <Products>[];
      json["products"].forEach((v) {
        _products!.add(Products.fromJson(v));
      });
    }
  }

}

class Products {
  String? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typedId;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typedId
});

  Products.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    stars = json["stars"];
    img = json["image"];
    location = json["location"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    typedId = json["type_id"];
  }
}