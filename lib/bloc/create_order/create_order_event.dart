import 'package:equatable/equatable.dart';
import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/product_model.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class InitialLoadEvent extends CreateOrderEvent {
  const InitialLoadEvent();

  @override
  List<Object> get props => [];
}

class CreateProductEvent extends CreateOrderEvent {
  const CreateProductEvent({
    required this.name,
    this.description = '',
  });

  final String name;
  final String description;

  @override
  List<Object> get props => [name, description];
}

class AddOrderProductEvent extends CreateOrderEvent {
  const AddOrderProductEvent({
    required this.product,
  });

  final Product product;

  @override
  List<Object> get props => [product];
}

class RemoveOrderProductEvent extends CreateOrderEvent {
  const RemoveOrderProductEvent({
    required this.orderProduct,
  });

  final OrderProduct orderProduct;

  @override
  List<Object> get props => [orderProduct];
}

class IncreseOrderProductQuantityEvent extends CreateOrderEvent {
  const IncreseOrderProductQuantityEvent({
    required this.orderProduct,
  });

  final OrderProduct orderProduct;

  @override
  List<Object> get props => [orderProduct];
}
