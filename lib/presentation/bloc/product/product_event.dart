import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  final int page;
  final bool loadMore;

  const LoadProducts({this.page = 1, this.loadMore = false});

  @override
  List<Object> get props => [page, loadMore];
}

class LoadMoreProducts extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final int categoryId;

  const LoadProductsByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}


// import 'package:equatable/equatable.dart';
//
// abstract class ProductEvent extends Equatable {
//   const ProductEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class LoadProducts extends ProductEvent {
//   final int page;
//
//   const LoadProducts({this.page = 1});
//
//   @override
//   List<Object> get props => [page];
// }
//
// class LoadProductsByCategory extends ProductEvent {
//   final int categoryId;
//
//   const LoadProductsByCategory(this.categoryId);
//
//   @override
//   List<Object> get props => [categoryId];
// }