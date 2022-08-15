import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/order_entity.dart';

enum PendingOrdersStatus { initialState, loadingOrders, loadingSucces }

class PendingOrdersState extends Equatable {
  const PendingOrdersState({
    this.status = PendingOrdersStatus.initialState,
    this.orders = const [],
  });

  final PendingOrdersStatus status;
  final List<Order> orders;

  PendingOrdersState copyWith({
    PendingOrdersStatus Function()? status,
    List<Order> Function()? orders,
  }) {
    return PendingOrdersState(
      status: status != null ? status() : this.status,
      orders: orders != null ? orders() : this.orders,
    );
  }

  @override
  List<Object?> get props => [status, orders];
}
