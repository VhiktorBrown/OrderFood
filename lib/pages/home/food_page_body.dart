import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/data/repository/popular_products_repo.dart';
import 'package:order_food/pages/food/food_details.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/icon_and_text.dart';
import 'package:order_food/widgets/small_text.dart';

import '../../data/controllers/recommended_products_controller.dart';
import '../../data/models/product.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    //set a listener on pageController
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //showing the Card items of Image and food details
        GetBuilder<PopularProductsController>(builder: (popularProducts) {
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
            //helps with navigating to another page
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductsList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductsList[position]);
                  }),
          ):const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),

        //showing the dots indicator
        GetBuilder<PopularProductsController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductsList.isEmpty?1:popularProducts.popularProductsList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        SizedBox(
          height: Dimensions.height30,
        ),

        //showing Recommended text and small dot
        Container(
          margin: EdgeInsets.all(Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),

        //Display list of food items
        GetBuilder<RecommendedProductsController>(builder: (recommendedProducts) {
          return recommendedProducts.isLoaded?ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProducts.isLoaded?recommendedProducts.recommendedProductsList.length:1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          height: Dimensions.listViewImageSize,
                          width: Dimensions.listViewImageSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/food2.jpg"))
                          ),
                        ),

                        //here is for the Text section of each Popular item showing food
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContainer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20)
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProducts.recommendedProductsList[index].name!,),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "Traditional food available."),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndTextWidget(icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(icon: Icons.location_on,
                                          text: "1.7 km",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(icon: Icons.access_time_rounded,
                                          text: "35 min",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }): const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, Products popularProduct){
    Matrix4 matrix = Matrix4.identity();
    
    if(index == _currentPageValue.floor()){
      var currentScale = 1-(_currentPageValue-index)*(1-scaleFactor);
      var currentTrans = height*(1-currentScale)/2;

      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else if(index == _currentPageValue.floor()+1){
      var currentScale = scaleFactor+(_currentPageValue-index+1)*(1-scaleFactor);
      var currentTrans = height*(1-currentScale)/2;

      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else if(index == _currentPageValue.floor()-1){
      var currentScale = 1-(_currentPageValue-index)*(1-scaleFactor);
      var currentTrans = height*(1-currentScale)/2;

      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, height*(1-currentScale)/2, 0);
    }
    
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven? const Color(0XFF69c5df) : const Color(0XFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      popularProduct.img!
                  ),
              ),
            ),
        ),
          ),
          Align(
            //Takes the container to the bottom of the Stack
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.textColor,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
                child: AppColumn(text: popularProduct.name!,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
