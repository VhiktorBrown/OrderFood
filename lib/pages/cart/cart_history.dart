import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/small_text.dart';

import '../../data/models/cart.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    //since Map cannot be access using index, we'll transfer the details of Map into this list
    List<int> cartOrderItemsList=[];

    //create a Map Object and add all Cart Details into it
    Map<String, int> cartOrderItems = {};

    for(int i = 0; i < cartHistoryList.length; i++){
      //convert Date into a Format without seconds and Miliseconds
      String time = DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.parse(cartHistoryList[i].time!));

      if(cartOrderItems.containsKey(time)){
        cartOrderItems.update(time, (value) => ++value);
      }else {
        cartOrderItems.putIfAbsent(time, () => 1);
      }
    }


    //now convert Map to List
    List returnOrderAsList(){
      return cartOrderItems.entries.map((e) => e.value).toList();
    }

    List<String> returnCartOrderTimeList(){
      return cartOrderItems.entries.map((e) => e.key).toList();
    }

    List orderList = returnOrderAsList();

    //Now, loop through them to get the various layers of Orders
    int savedCount = 0;
    for(int x = 0; x<cartOrderItems.length; x++){
      for(int y = 0; y < orderList[x]; y++){
        print(cartHistoryList[savedCount++].time);
      }
    }

    cartOrderItems.forEach((key, value) {
      print("Cart Order Items $value");
      //add the contents of Map into Arraylist so it can be used in UI for iteration
      cartOrderItemsList.add(value);
    });

    for(int i = 0; i < cartOrderItems.length; i++){
      print(cartOrderItems[i]);
    }

    //counter to track HistoryList
    int counter =0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white, ),
                const AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor, backgroundColor: Colors.white,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.width20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                  child: ListView(
                    children: [
                      for(int i = 0; i < cartOrderItems.length; i++)
                        Container(
                          height: Dimensions.height30*4,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ((){
                                var time = DateFormat('E, d MMM yyyy hh:mm a').format(DateTime.parse(cartHistoryList[counter].time!));
                                return BigText(text: time);
                              }()),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(cartOrderItemsList[i], (index) {
                                        if(counter < cartHistoryList.length){
                                          counter++;
                                        }
                                        return index<=2?Container(
                                          height: Dimensions.height20*4,
                                          width: Dimensions.height20*4,
                                          margin: EdgeInsets.only(right: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(cartHistoryList[counter-1].img!)
                                              )
                                          ),
                                        ):Container();
                                      })
                                  ),
                                  Container(
                                    height: Dimensions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total"),
                                        BigText(text: cartOrderItemsList[i]>1?cartOrderItemsList[i].toString() +" Items":cartOrderItemsList[i].toString() +" Item", color: AppColors.titleColor, ),
                                        GestureDetector(
                                          onTap: (){
                                            var timeList = returnCartOrderTimeList();
                                            Map<String, Cart> cartMap = Map();

                                            for(int j = 0; j < cartHistoryList.length; j++){
                                              //loop through each object and confirm whether
                                              //the time is equal to the time for this particular History item
                                              if(DateFormat('E, d MMM yyyy HH:mm:ss').format(DateTime.parse(cartHistoryList[j].time!))==timeList[i]){
                                                cartMap.putIfAbsent(cartHistoryList[j].id!, () => Cart.fromJson(jsonDecode(jsonEncode(cartHistoryList[j]))));
                                              }
                                            }

                                            Get.find<CartController>().setItems = cartMap;

                                            //add and update the Cart History in SharedPreferences.
                                            Get.find<CartController>().addToCartList();

                                            //move to Cart page
                                            Get.toNamed(RouteHelper.cartDetails);

                                            //TODO Remove later
                                            print("Time: ${timeList[i]}");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                              border: Border.all(width: 1, color: AppColors.mainColor),
                                            ),
                                            child: SmallText(text: "one more", color: AppColors.mainColor,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),),
            ),
          )
        ],
      ),
    );
  }
}
