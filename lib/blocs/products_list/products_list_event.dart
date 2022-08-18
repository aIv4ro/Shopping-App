import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/product_entity.dart';

abstract class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNextPageEvent extends ProductsListEvent {
  const LoadNextPageEvent();
}

class RemoveProductEvent extends ProductsListEvent {
  const RemoveProductEvent({required this.product});
  final Product product;

  @override
  List<Object?> get props => [product];
}

class AddProductEvent extends ProductsListEvent {
  const AddProductEvent({required this.product});
  final Product product;

  @override
  List<Object?> get props => [product];
}
