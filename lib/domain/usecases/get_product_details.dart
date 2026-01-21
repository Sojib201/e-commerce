import '../../data/models/product_details_data_model.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetProductDetails {
  final ProductRepository repository;

  GetProductDetails(this.repository);

  Future<({ProductDetailsDataModel? data, Failure? failure})> call(String slug) async {
    return await repository.getProductDetails(slug);
  }
}