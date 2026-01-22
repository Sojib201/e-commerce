import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_list_data_model.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/get_products_by_category.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductsByCategory getProductsByCategory;

  List<ProductData>  _allFetchedProducts = [];

  ProductBloc({
    required this.getProducts,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    if (event.loadMore && state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(ProductLoadingMore(currentState.allProducts));
    } else {
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

        if (event.page == 1) {
          _allFetchedProducts = List.from(newProducts);
        } else {
          _allFetchedProducts.addAll(newProducts);
        }

        if (event.loadMore && state is ProductLoadingMore) {
          final currentState = state as ProductLoadingMore;
          final updatedProducts = [...currentState.currentProducts, ...newProducts];

          emit(ProductLoaded(
            productData: productData,
            allProducts: updatedProducts,
            hasReachedMax: hasReachedMax,
            currentPage: currentPage,
          ));
        } else {
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

  void _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) {
    if (event.query.isEmpty) {
      if (_allFetchedProducts.isNotEmpty) {
        add(const LoadProducts());
      }
      return;
    }

    final filteredList = _allFetchedProducts.where((product) {
      final name = product.name?.toLowerCase() ?? "";
      final shortName = product.shortName?.toLowerCase() ?? "";
      final query = event.query.toLowerCase();
      return name.contains(query) || shortName.contains(query);
    }).toList();

    emit(ProductSearchLoaded(filteredList));
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

