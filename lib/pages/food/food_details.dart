import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/pages/home/main_food_page.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_column.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/expanded_text.dart';

import '../../data/controllers/cart_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_details.dart';

class FoodDetails extends StatelessWidget {
  int pageId;
  String page;
  FoodDetails({Key? key, required this.pageId, required this.page }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductsController>().popularProductsList[pageId];
    //set Quantity back to Zero
    Get.find<PopularProductsController>().reInitQuantity(product, Get.find<CartController>()); //gets the instance of Cart Controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Food image of Height 350
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.foodDetailImageHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.img!),
                ),
                )
              ),
          ),
          //Here's the Two icons on the left and right
          Positioned(
            //Holds the 2 icons at the top
            top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        if(page=="cartPage"){
                          Get.toNamed(RouteHelper.getCartDetails());
                        }else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios,)
                  ),
                  GetBuilder<PopularProductsController>(builder: (popularProducts) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartDetails());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart,),

                          //Here, we check if total items in cart is greater or equal to 1
                          popularProducts.totalItems>=1?
                              //if it is, show this Positioned widget
                          Positioned(
                            top: 0, right: 0,
                              child: AppIcon(icon: Icons.circle,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                                size: 20,),
                          ):
                              //If not, show this empty container(invisible)
                            Container(),
                          Get.find<PopularProductsController>().totalItems>=1?
                          Positioned(
                            top: 2, right: 4,
                            child: BigText(text: Get.find<PopularProductsController>().totalItems.toString(),
                              size: 12,
                            color: Colors.white,
                            ),
                          ):
                          Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          //Here's more details about the food
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.foodDetailImageHeight-20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!, stars: product.stars!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introducing"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ExpandedText(text: product.description!,)
                      ),
                    )
                  ],
                ),
              ),
          ),

        ]
      ),
      //Bottom Bar
      bottomNavigationBar: GetBuilder<PopularProductsController>(builder: (popularProducts){
        return Container(
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
          height: Dimensions.height30*4,
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
                    GestureDetector(
                      onTap: () {
                        popularProducts.setQuantity(false);
                      },
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width10,),
                    BigText(text: popularProducts.inCartItems.toString(), color: AppColors.signColor,),
                    SizedBox(width: Dimensions.width10,),
                    GestureDetector(
                      onTap: (){
                        popularProducts.setQuantity(true);
                      },
                      child: const Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  //add this product to Cart
                  popularProducts.addItem(product);
                },
                child: Container(
                    padding: EdgeInsets.all(Dimensions.radius20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: BigText(text: "\$${product.price} | Add to cart", color: Colors.white,)
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
