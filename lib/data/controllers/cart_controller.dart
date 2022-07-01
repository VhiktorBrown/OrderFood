import 'package:get/get.dart';
import 'package:order_food/data/models/cart.dart';

import '../models/product.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController{
  CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, Cart> _items = {};

  Map<String, Cart> get items=> _items;

  void addItems(Products product, int quantity){
    //print("Length of Map item is: " + items.length.toString());

    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        return Cart(
            id: value.id,
            name: value.name,
            quantity: value.quantity!+quantity,
            isExist: true,
            price: value.price,
            img: value.img,
            time: DateTime.now().toString()
        );
      });
    }else {
      _items.putIfAbsent(product.id!, () {
        // print("Printing Product ${product.id!}$quantity");
        _items.forEach((key, value) {
          // print("Quantity is: " +  value.quantity.toString());
        });

        return Cart(
            id: product.id,
            name: product.name,
            quantity: quantity,
            isExist: true,
            price: product.price,
            img: product.img,
            time: DateTime.now().toString()
        );
      });
    }

    }

    bool existsInCart(Products product){
      if(_items.containsKey(product.id)){
        return true;
      }
      return false;
    }


}