import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/order/order_event.dart';
import 'package:shopping/blocs/order/order_state.dart';
import 'package:shopping/domain/repositories/i_order_repository.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required this.orderRepository,
    required this.userRepository,
    required this.productRepository,
  }) : super(const OrderState()) {
    on<LoadOrderEvent>(_loadOrder);
  }

  final IOrderRepository orderRepository;
  final IUserRepository userRepository;
  final IProductRepository productRepository;

  FutureOr<void> _loadOrder(
    LoadOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: () => OrderStatus.loadingOrder));
    try {
      final order = await orderRepository.findById(id: event.id);
      emit(
        state.copyWith(
          status: () => OrderStatus.orderLoadSucess,
          order: () => order,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: () => OrderStatus.orderLoadError));
    }
  }
}
