import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/home_data_model.dart';
import '../models/product_list_data_model.dart';
import '../models/product_details_data_model.dart';
import '../models/product_by_category_data_model.dart';

abstract class ProductRemoteDataSource {
  Future<HomeDataModel> getHomeData();
  Future<ProductListDataModel> getProducts({int page = 1});
  Future<ProductDetailsDataModel> getProductDetails(String slug);
  Future<ProductByCategoryDataModel> getProductsByCategory(int categoryId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<HomeDataModel> getHomeData() async {
    final url = ApiConstants.homePage;
    debugPrint('GETTING: $url');

    try {
      final response = await client.get(
        Uri.parse(ApiConstants.homePage),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE FROM $url: ${response.body}');
        return homeDataModelFromJson(response.body);
      } else {
        throw ServerException('Failed to load home data');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<ProductListDataModel> getProducts({int page = 1}) async {
    final url = ApiConstants.productList;
    debugPrint('GETTING product: $url');

    try {
      final response = await client.get(
        Uri.parse('${ApiConstants.productList}?page=$page'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE FROM $url: ${response.body}');
        return productListDataModelFromJson(response.body);
      } else {
        throw ServerException('Failed to load products');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<ProductDetailsDataModel> getProductDetails(String slug) async {
    final url = ApiConstants.productDetails(slug);
    debugPrint('GETTING DETAILS: $url');

    try {
      final response = await client.get(
        Uri.parse(ApiConstants.productDetails(slug)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE FROM $url: ${response.body}');
        return productDetailsDataModelFromJson(response.body);
      } else {
        throw ServerException('Failed to load product details');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<ProductByCategoryDataModel> getProductsByCategory(int categoryId) async {
    final url = ApiConstants.productByCategory(categoryId);
    debugPrint('GETTING CATEGORY PRODUCTS: $url');

    try {
      final response = await client.get(
        Uri.parse(ApiConstants.productByCategory(categoryId)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE FROM $url: ${response.body}');
        return productByCategoryDataModelFromJson(response.body);
      } else {
        throw ServerException('Failed to load category products');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
}