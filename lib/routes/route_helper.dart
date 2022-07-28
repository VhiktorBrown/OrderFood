import 'package:get/get.dart';
import 'package:order_food/pages/auth/sign_in_page.dart';
import 'package:order_food/pages/cart/cart_details.dart';
import 'package:order_food/pages/food/food_details.dart';
import 'package:order_food/pages/food/recommended_food_details.dart';
import 'package:order_food/pages/home/home_page.dart';
import 'package:order_food/pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartDetails = "/cart-details";
  static const String signIn = "/sign-in";

  static String getSplashPage()=> splashPage;
  static String getInitial()=> initial;
  static String getPopularFood(int id, String page)=> '$popularFood?pageId=$id&page=$page';
  static String getRecommendedFood(int id, String page)=> '$recommendedFood?pageId=$id&page=$page';
  static String getCartDetails() => cartDetails;
  static String getSignInPage() => signIn;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=> const SplashPage()),

    GetPage(name: "/", page: ()=> const HomePage()),

    //For Recommended Page
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!), page: page!);
    },
      transition: Transition.fadeIn,
    ),

    //For Popular Page
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return FoodDetails(pageId: int.parse(pageId!), page: page!);
    },
      transition: Transition.fadeIn,
    ),

    //For Cart Page Details
    GetPage(name: cartDetails, page: () {
      return const CartDetails();
    },
    transition: Transition.fadeIn),

    //For Sign In Page
    GetPage(name: signIn, page: () {
      return const SignInPage();
    },
        transition: Transition.fadeIn),
  ];
}