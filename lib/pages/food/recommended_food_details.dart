import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/data/controllers/recommended_products_controller.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/expanded_text.dart';

import '../../data/controllers/cart_controller.dart';
import '../../widgets/big_text.dart';
class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductsController>().recommendedProductsList[pageId];
    Get.find<PopularProductsController>().reInitQuantity(product, Get.find<CartController>()); //gets the instance of Cart Controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
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
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductsController>(builder: (popularProducts) {
                  return GestureDetector(
                    onTap: (){
                      if(popularProducts.totalItems >= 1){
                        Get.toNamed(RouteHelper.getCartDetails());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart,),

                        //Here, we check if total items in cart is greater or equal to 1
                        Get.find<PopularProductsController>().totalItems>=1?
                        //if it is, show this Positioned widget
                        const Positioned(
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
                }),
              ],
            ),
            //This is the Widget showing the title of this food at the bottom of App Bar
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.font20),
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                  width: double.maxFinite,
                  child: Center(child: BigText(size: Dimensions.font26,  text: product.name!))
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          product.img!
                      ),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                        child: ExpandedText(
                            text: product.description!,
                        ),

                    ),
                  ],
                ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(builder: (productController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                        productController.setQuantity(true);
                      },
                      child: AppIcon(iconSize: Dimensions.iconSize24, icon: Icons.add, backgroundColor: AppColors.mainColor, iconColor: Colors.white,)),
                  BigText(text: "\$ ${product.price!} X ${productController.inCartItems}", size: Dimensions.font26, color: AppColors.mainBlackColor,),
                  GestureDetector(
                      onTap: (){
                        productController.setQuantity(false);
                      },
                      child: AppIcon(iconSize: Dimensions.iconSize24, icon: Icons.remove, backgroundColor: AppColors.mainColor, iconColor: Colors.white,)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
              //TODO Fix issue with height
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
                    child: AppIcon(
                      icon: Icons.favorite,
                      iconColor: AppColors.mainColor,
                      backgroundColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      productController.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.radius20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: BigText(text: "\$ ${product.price!} Add to cart", color: Colors.white,),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },)
    );
  }
}
