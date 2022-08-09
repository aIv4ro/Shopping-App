import 'package:equatable/equatable.dart';
import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/models/user_model.dart';

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
    this.products = const [],
    this.users = const [],
  });

  final CreateOrderStatus status;
  final List<OrderProduct> orderProducts;
  final List<Product> products;
  final List<User> users;

  CreateOrderState copyWith({
    CreateOrderStatus Function()? status,
    List<OrderProduct> Function()? orderProducts,
    List<Product> Function()? products,
    List<User> Function()? users,
  }) {
    return CreateOrderState(
      status: status != null ? status() : this.status,
      orderProducts:
          orderProducts != null ? orderProducts() : this.orderProducts,
      products: products != null ? products() : this.products,
      users: users != null ? users() : this.users,
    );
  }

  @override
  List<Object?> get props => [status, orderProducts, products, users];
}
