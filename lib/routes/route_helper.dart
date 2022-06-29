import 'package:get/get.dart';
import 'package:order_food/pages/food/food_details.dart';
import 'package:order_food/pages/food/recommended_food_details.dart';
import 'package:order_food/pages/home/main_food_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial()=> '$initial';
  static String getPopularFood(int id)=> '$popularFood?pageId=$id';
  static String getRecommendedFood(int id)=> '$recommendedFood?pageId=$id';

  static List<GetPage> routes = [
    GetPage(name: "/", page: ()=> MainFoodPage()),

    //For Recommended Page
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!),);
    },
      transition: Transition.fadeIn,
    ),

    //For Popular Page
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      return FoodDetails(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),
  ];
}