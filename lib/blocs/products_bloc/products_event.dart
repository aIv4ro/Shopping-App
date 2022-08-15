import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/product_entity.dart';

class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNextPageEvent extends ProductsEvent {
  const LoadNextPageEvent();
}

class DeleteProductEvent extends ProductsEvent {
  const DeleteProductEvent({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}

class UpdateProductEvent extends ProductsEvent {
  const UpdateProductEvent({required this.product});
  final Product product;

  @override
  List<Object?> get props => [product];
}
