import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../models/home_data_model.dart';
import '../models/product_list_data_model.dart';
import '../models/product_details_data_model.dart';
import '../models/product_by_category_data_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<({HomeDataModel? data, Failure? failure})> getHomeData() async {
    try {
      final result = await remoteDataSource.getHomeData();
      return (data: result, failure: null);
    } on ServerException catch (e) {
      return (data: null, failure: ServerFailure(e.message));
    } on NetworkException catch (e) {
      return (data: null, failure: NetworkFailure(e.message));
    }
  }

  @override
  Future<({ProductListDataModel? data, Failure? failure})> getProducts({int page = 1}) async {
    try {
      final result = await remoteDataSource.getProducts(page: page);
      return (data: result, failure: null);
    } on ServerException catch (e) {
      return (data: null, failure: ServerFailure(e.message));
    } on NetworkException catch (e) {
      return (data: null, failure: NetworkFailure(e.message));
    }
  }

  @override
  Future<({ProductDetailsDataModel? data, Failure? failure})> getProductDetails(String slug) async {
    try {
      final result = await remoteDataSource.getProductDetails(slug);
      return (data: result, failure: null);
    } on ServerException catch (e) {
      return (data: null, failure: ServerFailure(e.message));
    } on NetworkException catch (e) {
      return (data: null, failure: NetworkFailure(e.message));
    }
  }

  @override
  Future<({ProductByCategoryDataModel? data, Failure? failure})> getProductsByCategory(int categoryId) async {
    try {
      final result = await remoteDataSource.getProductsByCategory(categoryId);
      return (data: result, failure: null);
    } on ServerException catch (e) {
      return (data: null, failure: ServerFailure(e.message));
    } on NetworkException catch (e) {
      return (data: null, failure: NetworkFailure(e.message));
    }
  }
}