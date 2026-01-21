import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetails extends ProductDetailsEvent {
  final String slug;

  const LoadProductDetails(this.slug);

  @override
  List<Object> get props => [slug];
}