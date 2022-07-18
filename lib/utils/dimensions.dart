import 'package:get/get.dart';
class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.52;
  static double pageViewContainer = screenHeight/3.65;
  static double pageViewTextContainer = screenHeight/6.7;

  //height for padding and margin
  static double height10 = screenHeight/80.5;
  static double height20 = screenHeight/40.25;
  static double height15 = screenHeight/53.7;
  static double height30 = screenHeight/26.8;
  //TODO Get the Divisor Ratio
  static double height45 = screenHeight/17.9;

  //width for padding and margin
  static double width10 = screenHeight/80.5;
  static double width20 = screenHeight/40.25;
  static double width15 = screenHeight/53.7;
  static double width30 = screenHeight/26.8;
  //TODO Get the Divisor Ratio
  static double width45 = screenHeight/17.9;

  static double font16 = screenHeight/50.3;
  static double font20 = screenHeight/40.25;
  static double font26 = screenHeight/30.96;

  static double radius15 = screenHeight/53.7;
  static double radius20 = screenHeight/40.25;
  static double radius30 = screenHeight/26.8;

  static double iconSize24 = screenHeight/33.5;
  static double iconSize16 = screenHeight/50.3;

  static double listViewImageSize = screenWidth/3.2;
  static double listViewTextContainer = screenWidth/3.84;

  //image height for Popular food image in details page
  static double foodDetailImageHeight = screenHeight/2.3;

  static double bottomBarHeight = screenHeight/7.71;

  //for Splash Screen
  static double splashImage = screenWidth/3.22;
}