import 'package:equatable/equatable.dart';
import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/product_model.dart';

enum CreateOrderStatus {
  initialStatus, creatingProduct, productCreated
}

class CreateOrderState extends Equatable {
  const CreateOrderState({
    this.status = CreateOrderStatus.initialStatus,
    this.orderProducts = const [],
    this.products = const [],
  });

  final CreateOrderStatus status;
  final List<OrderProduct> orderProducts;
  final List<Product> products;

  CreateOrderState copyWith({
    CreateOrderStatus Function()? status,
    List<OrderProduct> Function()? orderProducts,
    List<Product> Function()? products,
  }) {
    return CreateOrderState(
      status: status != null ? status() : this.status,
      orderProducts: orderProducts != null ? orderProducts() : this.orderProducts,
      products: products != null ? products() : this.products,
    );
  }

  @override
  List<Object?> get props => [status];
}
