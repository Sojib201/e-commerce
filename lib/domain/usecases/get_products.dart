import '../../data/models/product_list_data_model.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<({ProductListDataModel? data, Failure? failure})> call({int page = 1}) async {
    return await repository.getProducts(page: page);
  }
}