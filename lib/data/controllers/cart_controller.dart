import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/models/cart.dart';
import '../../utils/colors.dart';
import '../models/product.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController{
  CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, Cart> _items = {};

  Map<String, Cart> get items=> _items;

  void addItems(Products product, int quantity){
    int totalQuantity=0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {

        //set total quantity
        totalQuantity = value.quantity!+quantity;

        return Cart(
            id: value.id,
            name: value.name,
            quantity: value.quantity!+quantity,
            isExist: true,
            price: value.price,
            img: value.img,
            time: DateTime.now().toString(),
            product: product,
        );
      });

      //check for total quantity and remove
      if(totalQuantity <=0){
        _items.remove(product.id!);
      }

    }else {
      if(quantity > 0){
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
              time: DateTime.now().toString(),
              product: product
          );
        });
        }else {
          Get.snackbar("Empty quantity", "Quantity has to be more than zero.",
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white);
        }
      }
    update();
    }

    bool existsInCart(Products product){
      if(_items.containsKey(product.id)){
        return true;
      }
      return false;
    }

    int getQuantity(Products product){
    var quantity=0;
    if(_items.containsKey(product.id!)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity = value.quantity! + totalQuantity;
    });
    return totalQuantity;
  }

  List<Cart> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }


}