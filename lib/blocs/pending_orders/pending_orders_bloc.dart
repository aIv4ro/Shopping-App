import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_event.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_state.dart';
import 'package:shopping/domain/repositories/i_order_repository.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class PendingOrdersBloc extends Bloc<PendingOrdersEvent, PendingOrdersState> {
  PendingOrdersBloc({
    required this.orderRepository,
    required this.userRepository,
    required this.productRepository,
  }) : super(const PendingOrdersState()) {
    on<LoadPendingOrdersEvent>(_loadPendingOrders);
  }

  final IOrderRepository orderRepository;
  final IUserRepository userRepository;
  final IProductRepository productRepository;

  FutureOr<void> _loadPendingOrders(
    LoadPendingOrdersEvent event,
    Emitter<PendingOrdersState> emit,
  ) async {
    emit(state.copyWith(status: () => PendingOrdersStatus.loadingOrders));
    final orders = await orderRepository.findAll();
    emit(
      state.copyWith(
        status: () => PendingOrdersStatus.loadingSucces,
        orders: () => orders,
      ),
    );
  }
}
