import 'package:get/get.dart';
import 'package:order_food/data/api/api_client.dart';
import 'package:order_food/utils/constants.dart';

class PopularProductsRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductsRepo({required this.apiClient});

  Future<Response> getPopularProductsList() async{
    return await apiClient.getData(Constants.POPULAR_PRODUCT_URL);
  }

  Future<Response> getRecommendedProductsList() async{
    return await apiClient.getData(Constants.POPULAR_PRODUCT_URL);
  }
}