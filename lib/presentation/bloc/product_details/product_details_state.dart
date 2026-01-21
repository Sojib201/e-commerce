import 'package:equatable/equatable.dart';
import '../../../data/models/product_details_data_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsDataModel productDetails;

  const ProductDetailsLoaded(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}