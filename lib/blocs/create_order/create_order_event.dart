import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';

abstract class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class InitialLoadEvent extends CreateOrderEvent {
  const InitialLoadEvent();
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

class PostOrderEvent extends CreateOrderEvent {
  const PostOrderEvent({
    required this.toUser,
  });

  final User toUser;

  @override
  List<Object> get props => [toUser];
}
