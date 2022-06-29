import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../models/Product.dart';
import '../repository/recommended_products_repo.dart';

class RecommendedProductsController extends GetxController{

  RecommendedProductsRepo recommendedProductsRepo;

  RecommendedProductsController({required this.recommendedProductsRepo});

  //initialise List
  List<dynamic> _recommendedProductsList = [];

  //to monitor the status of request, whether successful or not
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //to make the product list accessible from anywhere in the UI.
  List<dynamic> get recommendedProductsList => _recommendedProductsList;

  Future<void> getRecommendedProductsList() async{
    Response response = await recommendedProductsRepo.getRecommendedProductsList();

    //check if response was successful
    if(response.statusCode== 200){
      //TODO Remove later, just to confirm success for now
      print("Got the products");

      //to check if request was successful
      _isLoaded = true;

      _recommendedProductsList = [];
      _recommendedProductsList.addAll(Product.fromJson(response.body).products!.toList());
      update();
    }
  }
}