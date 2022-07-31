import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_event.dart';
import 'package:shopping/bloc/create_order/create_order_state.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/order_repository.dart';
import 'package:shopping/repositories/product_repository.dart';
import 'package:shopping/repositories/user_repository.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  CreateOrderBloc({
    required this.userRepository,
    required this.productRepository,
    required this.orderRepository,
  }) : super(const CreateOrderState()) {
    on<CreateProductEvent>(_createProductEvent);
    on<InitialLoadEvent>(_initialLoadEvent);
  }

  final UserRepository userRepository;
  final ProductRepository productRepository;
  final OrderRepository orderRepository;

  Future<void> _createProductEvent(CreateProductEvent event, Emitter<CreateOrderState> emit) async {
    final newProduct = await productRepository.createProduct(event.name, event.description);
    final products = List.of(state.products)..add(newProduct);

    emit(
      state.copyWith(
        status: () => CreateOrderStatus.productCreated,
        products: () => products,
      ),
    );
  }

  Future<void> _initialLoadEvent(InitialLoadEvent event, Emitter<CreateOrderState> emit) async {
    emit(
      state.copyWith(status: () => CreateOrderStatus.initalLoad)
    );
    
    final result = await Future.wait([
      userRepository.findAllUsers(),
      productRepository.findAllProducts()
    ]);

    final users = result[0] as List<User>;
    final products = result[1] as List<Product>;

    emit(
      state.copyWith(
        status: () => CreateOrderStatus.initialLoadSuccess,
        users: () => users,
        products: () => products,
      ),
    );
  }
}
