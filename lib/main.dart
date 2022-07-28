import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/helper/dependencies.dart' as dep;
import 'package:order_food/pages/auth/sign_in_page.dart';
import 'package:order_food/routes/route_helper.dart';
import 'data/controllers/popular_products_controller.dart';
import 'data/controllers/recommended_products_controller.dart';

Future<void> main() async{

  //to ensure that the dependencies are loaded before loading the UI
  WidgetsFlutterBinding.ensureInitialized();

  //initialize our dependencies before loading our app
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductsController>(builder: (_){
      return GetBuilder<RecommendedProductsController>(builder: (_){
        return GetBuilder<CartController>(builder: (cartController){
          return const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',

            home: SignInPage(),
            //initialRoute: RouteHelper.getSplashPage(),
            //getPages: RouteHelper.routes,
          );
        });
      });
    });
  }
}