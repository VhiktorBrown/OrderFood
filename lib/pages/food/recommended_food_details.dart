import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/recommended_products_controller.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/expanded_text.dart';

import '../../widgets/big_text.dart';
class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  RecommendedFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductsController>().recommendedProductsList[pageId];
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
                    Get.toNamed(RouteHelper.getInitial());
                  },
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined),
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
      bottomNavigationBar: Column(
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
                AppIcon(iconSize: Dimensions.iconSize24, icon: Icons.add, backgroundColor: AppColors.mainColor, iconColor: Colors.white,),
                BigText(text: "\$ ${product.price!} " + " X " + " 0 ", size: Dimensions.font26, color: AppColors.mainBlackColor,),
                AppIcon(iconSize: Dimensions.iconSize24, icon: Icons.remove, backgroundColor: AppColors.mainColor, iconColor: Colors.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            //TODO Fix issue with height
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
                  child: AppIcon(
                    icon: Icons.favorite,
                    iconColor: AppColors.mainColor,
                    backgroundColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.radius20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: BigText(text: "\$5.00 Add to cart", color: Colors.white,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
