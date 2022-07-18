
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/data/controllers/recommended_products_controller.dart';
import 'package:order_food/pages/home/main_food_page.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/small_text.dart';

import '../../widgets/app_icon.dart';

class CartDetails extends StatelessWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.height20,
            right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(MainFoodPage());
                    },
                      child: AppIcon(icon: Icons.home_outlined, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,)),
                  AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24,),
                ],
            )
          ),
          Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.height20,
            bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex = Get.find<PopularProductsController>()
                                        .popularProductsList.indexOf(cartList[index].product);

                                    if(popularIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartPage"));
                                    }else {
                                      var recommendedIndex = Get.find<RecommendedProductsController>()
                                          .recommendedProductsList.indexOf(cartList[index].product);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartPage"));
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.width20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              cartController.getItems[index].img!
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ ${cartController.getItems[index].price!}", color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.all(Dimensions.width10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItems(cartList[index].product!, -1);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: Dimensions.width10,),
                                                  BigText(text:cartList[index].quantity.toString()), //popularProducts.inCartItems.toString(), color: AppColors.signColor,),
                                                  SizedBox(width: Dimensions.width10,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      cartController.addItems(cartList[index].product!, 1);
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }),
                ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10,),
                    BigText(text: "\$${cartController.totalAmount}", color: AppColors.signColor,),
                    SizedBox(width: Dimensions.width10,),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //popularProducts.addItem(product);
                  //add the Items in the Cart to History after user checks out
                  cartController.addToHistory();
                },
                child: Container(
                    padding: EdgeInsets.all(Dimensions.radius20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: BigText(text: "Checkout", color: Colors.white,)
                ),
              )
            ],
          ),
        );
      },
      ),
    );
  }
}
