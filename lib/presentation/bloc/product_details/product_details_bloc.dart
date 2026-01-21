import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_product_details.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetails getProductDetails;

  ProductDetailsBloc({required this.getProductDetails}) : super(ProductDetailsInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event,
      Emitter<ProductDetailsState> emit,
      ) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetails(event.slug);

    if (result.failure != null) {
      emit(ProductDetailsError(result.failure!.message));
    } else if (result.data != null) {
      emit(ProductDetailsLoaded(result.data!));
    }
  }
}