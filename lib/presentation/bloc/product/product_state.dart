import 'package:equatable/equatable.dart';
import '../../../data/models/product_list_data_model.dart';
import '../../../data/models/product_by_category_data_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadingMore extends ProductState {
  final List<Datum> currentProducts;

  const ProductLoadingMore(this.currentProducts);

  @override
  List<Object> get props => [currentProducts];
}

class ProductLoaded extends ProductState {
  final ProductListDataModel productData;
  final List<Datum> allProducts;
  final bool hasReachedMax;
  final int currentPage;

  const ProductLoaded({
    required this.productData,
    required this.allProducts,
    required this.hasReachedMax,
    required this.currentPage,
  });

  ProductLoaded copyWith({
    ProductListDataModel? productData,
    List<Datum>? allProducts,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ProductLoaded(
      productData: productData ?? this.productData,
      allProducts: allProducts ?? this.allProducts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [productData, allProducts, hasReachedMax, currentPage];
}

class ProductCategoryLoaded extends ProductState {
  final ProductByCategoryDataModel productData;

  const ProductCategoryLoaded(this.productData);

  @override
  List<Object> get props => [productData];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}


// import 'package:equatable/equatable.dart';
// import '../../../data/models/product_list_data_model.dart';
// import '../../../data/models/product_by_category_data_model.dart';
//
// abstract class ProductState extends Equatable {
//   const ProductState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ProductInitial extends ProductState {}
//
// class ProductLoading extends ProductState {}
//
// class ProductLoaded extends ProductState {
//   final ProductListDataModel productData;
//
//   const ProductLoaded(this.productData);
//
//   @override
//   List<Object> get props => [productData];
// }
//
// class ProductCategoryLoaded extends ProductState {
//   final ProductByCategoryDataModel productData;
//
//   const ProductCategoryLoaded(this.productData);
//
//   @override
//   List<Object> get props => [productData];
// }
//
// class ProductError extends ProductState {
//   final String message;
//
//   const ProductError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }