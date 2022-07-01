import 'package:get/get.dart';
import 'package:order_food/data/api/api_client.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/data/controllers/popular_products_controller.dart';
import 'package:order_food/data/repository/popular_products_repo.dart';
import 'package:order_food/utils/constants.dart';

import '../data/controllers/recommended_products_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_products_repo.dart';

Future<void> init() async {
  //loading Api Client.
  Get.lazyPut(()=> ApiClient(appBaseUrl: Constants.BASE_URL));

  //loading Repositories
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //loading Controllers
  Get.lazyPut(() => PopularProductsController(popularProductsRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductsController(recommendedProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}