import '../../data/models/product_by_category_data_model.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<({ProductByCategoryDataModel? data, Failure? failure})> call(int categoryId) async {
    return await repository.getProductsByCategory(categoryId);
  }
}