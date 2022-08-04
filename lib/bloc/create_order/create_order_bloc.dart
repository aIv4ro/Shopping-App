import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_event.dart';
import 'package:shopping/bloc/create_order/create_order_state.dart';
import 'package:shopping/models/order_product_model.dart';
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
    on<AddOrderProductEvent>(_addOrderProductEvent);
    on<RemoveOrderProductEvent>(_removeOrderProductEvent);
    on<IncreseOrderProductQuantityEvent>(_increaseOrderProdductQuantity);
  }

  final UserRepository userRepository;
  final ProductRepository productRepository;
  final OrderRepository orderRepository;

  Future<void> _createProductEvent(
    CreateProductEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    final newProduct = await productRepository.createProduct(
      event.name,
      event.description,
    );
    final products = List.of(state.products)..add(newProduct);

    emit(
      state.copyWith(
        status: () => CreateOrderStatus.productCreated,
        products: () => products,
      ),
    );
  }

  Future<void> _initialLoadEvent(
    InitialLoadEvent event,
    Emitter<CreateOrderState> emit,
  ) async {
    emit(state.copyWith(status: () => CreateOrderStatus.initalLoad));

    final result = await Future.wait(
      [userRepository.findAllUsers(), productRepository.findAllProducts()],
    );

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

  void _addOrderProductEvent(
    AddOrderProductEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    final products = List.of(state.products)..remove(event.product);
    final newOrderProduct = OrderProduct(product: event.product, quantity: 1);
    final orderProducts = List.of(state.orderProducts)..add(newOrderProduct);

    emit(
      state.copyWith(
        products: () => products,
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
    final products = List.of(state.products)..add(event.orderProduct.product);

    emit(
      state.copyWith(
        products: () => products,
        orderProducts: () => orderProducts,
      ),
    );
  }

  void _increaseOrderProdductQuantity(
    IncreseOrderProductQuantityEvent event,
    Emitter<CreateOrderState> emit,
  ) {
    event.orderProduct.quantity += 1;
    final newOrderProduct = OrderProduct(
      product: event.orderProduct.product,
      quantity: event.orderProduct.quantity,
    );

    final oldOrderProductIndex = state.orderProducts.indexOf(
      event.orderProduct,
    );

    final orderProducts = List.of(state.orderProducts)
      ..removeAt(oldOrderProductIndex)
      ..insert(oldOrderProductIndex, newOrderProduct);

    emit(
      state.copyWith(
        orderProducts: () => orderProducts,
      ),
    );
  }
}
