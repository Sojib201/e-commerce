import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/get_products_by_category.dart';
import '../../../data/models/product_list_data_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductsByCategory getProductsByCategory;

  ProductBloc({
    required this.getProducts,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadProducts(
      LoadProducts event,
      Emitter<ProductState> emit,
      ) async {
    if (event.loadMore && state is ProductLoaded) {
      // Loading more products
      final currentState = state as ProductLoaded;
      emit(ProductLoadingMore(currentState.allProducts));
    } else {
      // Initial load
      emit(ProductLoading());
    }

    final result = await getProducts(page: event.page);

    if (result.failure != null) {
      emit(ProductError(result.failure!.message));
    } else if (result.data != null) {
      final productData = result.data!;
      final products = productData.products;

      if (products != null) {
        final newProducts = products.data ?? [];
        final currentPage = products.currentPage ?? 1;
        final lastPage = products.lastPage ?? 1;
        final hasReachedMax = currentPage >= lastPage;

        if (event.loadMore && state is ProductLoadingMore) {
          // Append new products to existing list
          final currentState = state as ProductLoadingMore;
          final updatedProducts = [...currentState.currentProducts, ...newProducts];

          emit(ProductLoaded(
            productData: productData,
            allProducts: updatedProducts,
            hasReachedMax: hasReachedMax,
            currentPage: currentPage,
          ));
        } else {
          // Initial load
          emit(ProductLoaded(
            productData: productData,
            allProducts: newProducts,
            hasReachedMax: hasReachedMax,
            currentPage: currentPage,
          ));
        }
      }
    }
  }

  Future<void> _onLoadMoreProducts(
      LoadMoreProducts event,
      Emitter<ProductState> emit,
      ) async {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      if (!currentState.hasReachedMax) {
        final nextPage = currentState.currentPage + 1;
        add(LoadProducts(page: nextPage, loadMore: true));
      }
    }
  }

  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());

    final result = await getProductsByCategory(event.categoryId);

    if (result.failure != null) {
      emit(ProductError(result.failure!.message));
    } else if (result.data != null) {
      emit(ProductCategoryLoaded(result.data!));
    }
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/usecases/get_products.dart';
// import '../../../domain/usecases/get_products_by_category.dart';
// import 'product_event.dart';
// import 'product_state.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final GetProducts getProducts;
//   final GetProductsByCategory getProductsByCategory;
//
//   ProductBloc({
//     required this.getProducts,
//     required this.getProductsByCategory,
//   }) : super(ProductInitial()) {
//     on<LoadProducts>(_onLoadProducts);
//     on<LoadProductsByCategory>(_onLoadProductsByCategory);
//   }
//
//   Future<void> _onLoadProducts(
//       LoadProducts event,
//       Emitter<ProductState> emit,
//       ) async {
//     emit(ProductLoading());
//
//     final result = await getProducts(page: event.page);
//
//     if (result.failure != null) {
//       emit(ProductError(result.failure!.message));
//     } else if (result.data != null) {
//       emit(ProductLoaded(result.data!));
//     }
//   }
//
//   Future<void> _onLoadProductsByCategory(
//       LoadProductsByCategory event,
//       Emitter<ProductState> emit,
//       ) async {
//     emit(ProductLoading());
//
//     final result = await getProductsByCategory(event.categoryId);
//
//     if (result.failure != null) {
//       emit(ProductError(result.failure!.message));
//     } else if (result.data != null) {
//       emit(ProductCategoryLoaded(result.data!));
//     }
//   }
// }