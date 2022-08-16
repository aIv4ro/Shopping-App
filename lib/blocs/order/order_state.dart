import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/order_entity.dart';

enum OrderStatus {
  initialStatus,
  loadingOrder,
  orderLoadSucess,
  orderLoadError,
}

class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.initialStatus,
    this.order = Order.empty,
  });

  final OrderStatus status;
  final Order order;

  OrderState copyWith({
    OrderStatus Function()? status,
    Order Function()? order,
  }) {
    return OrderState(
      status: status != null ? status() : this.status,
      order: order != null ? order() : this.order,
    );
  }

  @override
  List<Object?> get props => [status, order];
}
