import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controllers/popular_products_controller.dart';
import '../../data/controllers/recommended_products_controller.dart';
import '../../routes/route_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController _controller;

  _loadResources() async{
    //make calls to fetch our data
    await Get.find<PopularProductsController>().getPopularProductsList();
    await Get.find<RecommendedProductsController>().getRecommendedProductsList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    //After 3 seconds, go to Main page of app
    Timer(
      const Duration(seconds: 3),
        ()=> Get.toNamed(RouteHelper.getInitial())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/images/order_food_logo.png",))),
          Center(child: Image.asset("assets/images/order_food_logo_title.png",))
        ],
      ),
    );
  }
}
