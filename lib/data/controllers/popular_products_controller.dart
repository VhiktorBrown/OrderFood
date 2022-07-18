import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/data/models/product.dart';
import 'package:order_food/data/repository/popular_products_repo.dart';
import 'package:order_food/utils/colors.dart';

import '../models/cart.dart';
import '../models/product.dart';

class PopularProductsController extends GetxController{
  PopularProductsRepo popularProductsRepo;

  PopularProductsController({required this.popularProductsRepo});

  //initialise List
  List<dynamic> _popularProductsList = [];

  //to monitor the status of request, whether successful or not
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;

  late CartController _cartController;

  //to make the product list accessible from anywhere in the UI.
  List<dynamic> get popularProductsList => _popularProductsList;

  Future<void> getPopularProductsList() async{
    Response response = await popularProductsRepo.getPopularProductsList();

    //check if response was successful
    if(response.statusCode== 200){
      //TODO Remove later, just to confirm success for now
      print("Got the products");

      //to check if request was successful
      _isLoaded = true;

      _popularProductsList = [];
      _popularProductsList.addAll(Product.fromJson(response.body).products!.toList());
      update();
    }else {
      Get.snackbar("Response", "Something weird happened",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

   int checkQuantity(int quantity){
    if((_inCartItems+quantity) < 0){
      Get.snackbar("Item count", "You cannot go below 0",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);

      //to prevent the previous Cart Item to display when we reduce to zero, we do this.
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity) > 20){
      Get.snackbar("Item count", "You cannot exceed 20",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      return 20;
    }else {
      return quantity;
    }
  }

  void reInitQuantity(Products product, CartController cartController){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    bool exists = false;
    //now check if current product exists in cart
    exists = _cartController.existsInCart(product);

    //print tre or false based on result
    print("Exists?: $exists");

    if(exists){
      _inCartItems = _cartController.getQuantity(product);
    }

    //print the current quantity of this particular product.
    //print("Quantity in the cart is: $_inCartItems");
  }

  void addItem(Products product){
      _cartController.addItems(product, _quantity);

      //reset quantity back to 0
      _quantity = 0;
      _inCartItems = _cartController.getQuantity(product);


      _cartController.items.forEach((key, value) {
        print("Key is: " + value.id! + " Quantity is: " + value.quantity.toString());
      });

      update();
  }

  int get totalItems{
    return _cartController.totalItems;
  }

  List<Cart> get getItems{
    return _cartController.getItems;
  }
}