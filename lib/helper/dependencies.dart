import 'package:get/get.dart';
import 'package:order_food/data/api/api_client.dart';
import 'package:order_food/data/controllers/auth_controller.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/data/repository/popular_products_repo.dart';
import 'package:order_food/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controllers/recommended_products_controller.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_products_repo.dart';

  init() async {
  //initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);

  //loading Api Client.
  Get.lazyPut(()=> ApiClient(appBaseUrl: Constants.BASE_URL, sharedPreferences: sharedPreferences));

  //loading Repositories
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //loading Controllers
  Get.lazyPut(() => PopularProductsController(popularProductsRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductsController(recommendedProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

}