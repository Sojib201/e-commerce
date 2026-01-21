import '../../core/error/failures.dart';
import '../../data/models/home_data_model.dart';
import '../../data/models/product_list_data_model.dart';
import '../../data/models/product_details_data_model.dart';
import '../../data/models/product_by_category_data_model.dart';

abstract class ProductRepository {
  Future<({HomeDataModel? data, Failure? failure})> getHomeData();
  Future<({ProductListDataModel? data, Failure? failure})> getProducts({int page = 1});
  Future<({ProductDetailsDataModel? data, Failure? failure})> getProductDetails(String slug);
  Future<({ProductByCategoryDataModel? data, Failure? failure})> getProductsByCategory(int categoryId);
}