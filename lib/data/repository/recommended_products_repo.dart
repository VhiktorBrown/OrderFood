import 'package:get/get.dart';
import 'package:order_food/data/api/api_client.dart';
import 'package:order_food/utils/constants.dart';

class RecommendedProductsRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductsRepo({required this.apiClient});

  Future<Response> getRecommendedProductsList() async{
    return await apiClient.getData(Constants.POPULAR_PRODUCT_URL);
  }
}