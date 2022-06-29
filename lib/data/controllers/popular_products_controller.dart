import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/models/product.dart';
import 'package:order_food/data/repository/popular_products_repo.dart';
import 'package:order_food/utils/colors.dart';

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
    if(quantity < 0){
      Get.snackbar("Item count", "You cannot go below 0",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 0;
    }else if(quantity > 20){
      Get.snackbar("Item count", "You cannot exceed 20",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      return 20;
    }else {
      return quantity;
    }
  }

  void reInitQuantity(){
    _quantity = 0;
  }
}