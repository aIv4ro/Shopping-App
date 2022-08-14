import 'package:equatable/equatable.dart';

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
