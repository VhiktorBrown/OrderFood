import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:order_food/pages/cart/cart_details.dart';
import 'package:order_food/pages/food/food_details.dart';
import 'package:order_food/pages/food/recommended_food_details.dart';
import 'package:order_food/pages/home/main_food_page.dart';
import 'package:order_food/helper/dependencies.dart' as dep;
import 'package:order_food/routes/route_helper.dart';

import 'data/controllers/popular_products_controller.dart';
import 'data/controllers/recommended_products_controller.dart';

void main() {
  //to ensure that the dependencies are loaded before loading the UI
  WidgetsFlutterBinding.ensureInitialized();

  //initialize our dependencies before loading our app
  dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //make calls to fetch our data
    Get.find<PopularProductsController>().getPopularProductsList();
    Get.find<RecommendedProductsController>().getRecommendedProductsList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}