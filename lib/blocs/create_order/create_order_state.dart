import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/order_entity.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';

enum CreateOrderStatus {
  initialStatus,
  initalLoad,
  initialLoadSuccess,
  creatingOrder,
  orderCreated,
  orderCreationError,
}

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.status = CreateOrderStatus.initialStatus,
    this.orderProducts = const [],
    this.users = const [],
    this.pickedDate,
    this.pickedUser,
    this.createdOrder,
  });

  final CreateOrderStatus status;
  final List<OrderProduct> orderProducts;
  final List<User> users;
  final User? pickedUser;
  final DateTime? pickedDate;
  final Order? createdOrder;

  CreateOrderState copyWith({
    CreateOrderStatus Function()? status,
    List<OrderProduct> Function()? orderProducts,
    List<User> Function()? users,
    User? Function()? pickedUser,
    DateTime? Function()? pickedDate,
    Order? Function()? createdOrder,
  }) {
    return CreateOrderState(
      status: status?.call() ?? this.status,
      orderProducts: orderProducts?.call() ?? this.orderProducts,
      users: users?.call() ?? this.users,
      pickedUser: pickedUser?.call() ?? this.pickedUser,
      pickedDate: pickedDate?.call() ?? this.pickedDate,
      createdOrder: createdOrder?.call() ?? this.createdOrder,
    );
  }

  @override
  List<Object?> get props => [status, orderProducts, users, createdOrder];
}
