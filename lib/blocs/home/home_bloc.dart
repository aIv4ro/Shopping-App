import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';
import 'package:shopping/blocs/home/home_state.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';
import 'package:shopping/domain/repositories/i_auth_repository.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';
import 'package:shopping/domain/repositories/i_user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.authRepository,
    required this.userRepository,
    required this.productRepository,
  }) : super(const HomeState()) {
    on<LogoutEvent>(_logout);
    on<LoadCurrentUserEvent>(_loadCurrentUser);
    on<CreateProductEvent>(_createProduct);
  }

  final IAuthRepository authRepository;
  final IUserRepository userRepository;
  final IProductRepository productRepository;

  User? get user => authRepository.currentUser;

  Future<void> _logout(
    LogoutEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.logginout));
    authRepository.logout();
    emit(state.copyWith(status: () => HomeStatus.loggedout));
  }

  Future<void> _loadCurrentUser(
    LoadCurrentUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loadingCurrentUser));
    try {
      final user = await authRepository.getUserFromToken();
      authRepository.currentUser = user;
      emit(state.copyWith(status: () => HomeStatus.currentUserLoaded));
    } catch (err) {
      emit(state.copyWith(status: () => HomeStatus.currentUserLoadError));
    }
  }

  Future<void> _createProduct(
    CreateProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.creatingProduct));
    final product = Product(
      id: '',
      name: event.name,
      description: event.description,
    );

    await productRepository.create(model: product);

    emit(state.copyWith(status: () => HomeStatus.productCreated));
  }
}
