import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/domain/entities/order_entity.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';
import 'package:shopping/domain/repositories/i_order_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc({
    required this.userRepository,
    required this.orderRepository,
    required this.authRepository,
  }) : super(const CreateOrderState()) {
    on<AddOrderProductEvent>(_addOrderProductEvent);
    on<RemoveOrderProductEvent>(_removeOrderProductEvent);
    on<PostOrderEvent>(_postOrder);
    on<InitialLoadEvent>(_initialLoad);
    on<PickedUserChangeEvent>(_pickedUserChange);
    on<PickedDateChangeEvent>(_pickedDateChange);
  }

  final IUserRepository userRepository;
  final IOrderRepository orderRepository;
  final IAuthRepository authRepository;

  void _addOrderProductEvent(
    AddOrderProductEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final newOrderProduct = OrderProduct(
      product: event.product,
      quantity: event.product.increment,
      id: '',
    );
    final orderProducts = List.of(state.orderProducts)..add(newOrderProduct);

    emit(
      state.copyWith(
        orderProducts: () => orderProducts,
      ),
    );
  }

  void _removeOrderProductEvent(
    RemoveOrderProductEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final orderProducts = List.of(state.orderProducts)
      ..remove(event.orderProduct);

    emit(
      state.copyWith(
        orderProducts: () => orderProducts,
      ),
    );
  }

  Future<void> _postOrder(
    PostOrderEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    emit(state.copyWith(status: () => CreateOrderStatus.creatingOrder));
    final currentUser = await authRepository.getUserFromToken();
    final order = Order(
      id: '',
      fromUser: currentUser,
      toUser: event.toUser,
      orderProducts: state.orderProducts,
    );

    try {
      final newOrder = await orderRepository.create(model: order);
      emit(
        state.copyWith(
          status: () => CreateOrderStatus.orderCreated,
          createdOrder: () => newOrder,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: () => CreateOrderStatus.orderCreationError));
    }
  }

  FutureOr<void> _initialLoad(
    InitialLoadEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final users = await userRepository.findAll();
    emit(
      state.copyWith(
        users: () => users,
      ),
    );
  }

  FutureOr<void> _pickedUserChange(
    PickedUserChangeEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    emit(state.copyWith(pickedUser: () => event.pickedUser));
  }

  FutureOr<void> _pickedDateChange(
    PickedDateChangeEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    emit(state.copyWith(pickedDate: () => event.pickedDate));
  }
}
