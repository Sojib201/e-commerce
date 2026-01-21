class ApiConstants {
  static const String baseUrl = 'https://mamunuiux.com/flutter_task/api';
  static const String imageBaseUrl = 'https://mamunuiux.com/flutter_task/';

  static const String homePage = baseUrl;
  static const String productList = '$baseUrl/product';

  static String productDetails(String slug) => '$baseUrl/product/$slug';
  static String productByCategory(int id) => '$baseUrl/product-by-category/$id';
}