import '../../data/models/home_data_model.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetHomeData {
  final ProductRepository repository;

  GetHomeData(this.repository);

  Future<({HomeDataModel? data, Failure? failure})> call() async {
    return await repository.getHomeData();
  }
}