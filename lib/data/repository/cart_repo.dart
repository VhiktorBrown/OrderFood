import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/cart.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory = [];

  void addToCartList(List<Cart> cartList){
    cart=[];
    cartList.forEach((element) {
      element.time = DateTime.now().toString();

      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(Constants.CART_LIST, cart);
    getCartList();
  }

  List<Cart> getCartList(){
    List<String>? cart=[];

    if(sharedPreferences.containsKey(Constants.CART_LIST)){
      cart = sharedPreferences.getStringList(Constants.CART_LIST);
      print(cart.toString());
    }
    //initialize what's going to be returned as CartList
    List<Cart> cartList=[];
    
    //loop through String Cart to convert each string to an Actual object
    cart?.forEach((element) {
      cartList.add(Cart.fromJson(jsonDecode(element)));
    });
    
    return cartList;
  }

  List<Cart> getCartHistory(){
    if(sharedPreferences.containsKey(Constants.CART_HISTORY)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY)!;
    }

    //initialize a new Cart List
    List<Cart> cartHistoryList=[];

    cartHistory.forEach((element) {
      cartHistoryList.add(Cart.fromJson(jsonDecode(element)));
    });

    //then return Cart History List
    return cartHistoryList;
  }

  void addToCartHistoryList(){
    //check if History previously exists, add it into the String list
    if(sharedPreferences.containsKey(Constants.CART_HISTORY)){
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY)!;
    }

    for(int i = 0; i < cart.length; i++){
      cartHistory.add(cart[i]);
    }

    //remove items from Cart
    removeItemsFromCart();

    sharedPreferences.setStringList(Constants.CART_HISTORY, cartHistory);
    print("Length of History List ${getCartHistory().length}");
  }

  void removeItemsFromCart(){
    //set Cart to empty after clearing Cart SharedPreference
    cart=[];
    sharedPreferences.remove(Constants.CART_LIST);
  }
}