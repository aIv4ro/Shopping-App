import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';

enum CreateOrderStatus {
  initialStatus,
  initalLoad,
  initialLoadSuccess,
  creatingProduct,
  productCreated,
  orderCreated
}

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.status = CreateOrderStatus.initialStatus,
    this.orderProducts = const [],
    this.users = const [],
  });

  final CreateOrderStatus status;
  final List<OrderProduct> orderProducts;
  final List<User> users;

  CreateOrderState copyWith({
    CreateOrderStatus Function()? status,
    List<OrderProduct> Function()? orderProducts,
    List<Product> Function()? products,
    List<User> Function()? users,
  }) {
    return CreateOrderState(
      status: status?.call() ?? this.status,
      orderProducts: orderProducts?.call() ?? this.orderProducts,
      users: users?.call() ?? this.users,
    );
  }

  @override
  List<Object?> get props => [status, orderProducts, users];
}
