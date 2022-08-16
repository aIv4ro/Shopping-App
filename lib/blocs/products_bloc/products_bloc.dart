import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required this.productRepository,
  }) : super(const ProductsState()) {
    on<LoadNextPageEvent>(_loadNextPage);
    on<DeleteProductEvent>(_deleteProduct);
    on<CreateProductEvent>(_createProduct);
    on<UpdateProductEvent>(_updateProduct);
    on<FilterProductsEvent>(_filterChange);
  }

  final IProductRepository productRepository;

  FutureOr<void> _loadNextPage(
    LoadNextPageEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductsStatus.loadingPage));
    final newProducts = await productRepository.search(
      offset: state.offset,
      limit: state.limit,
    );

    emit(
      state.copyWith(
        status: () => ProductsStatus.pageLoaded,
        products: () => List.of(state.products)..addAll(newProducts),
        offset: () => state.offset + state.limit,
        hasReachedMax: () => newProducts.isEmpty,
      ),
    );
  }

  FutureOr<void> _deleteProduct(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ProductsStatus.deletingProduct,
        products: () => List.of(state.products)
          ..removeWhere((element) {
            return element.id == event.id;
          }),
      ),
    );
    final deletionSucces = await productRepository.delete(id: event.id);
    if (deletionSucces) {
      emit(state.copyWith(status: () => ProductsStatus.productDeleted));
    } else {
      emit(state.copyWith(status: () => ProductsStatus.productDeletionError));
    }
  }

  Future<void> _createProduct(
    CreateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductsStatus.creatingProduct));
    final product = Product(
      id: '',
      name: event.name,
      description: event.description,
    );

    try {
      final newProduct = await productRepository.create(model: product);
      final products = List.of(state.products)
        ..add(newProduct)
        ..sort((a, b) => a.name.compareTo(b.name));
      emit(
        state.copyWith(
          status: () => ProductsStatus.productCreated,
          products: () => products,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: () => ProductsStatus.productCreationError));
    }
  }

  FutureOr<void> _updateProduct(
    UpdateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductsStatus.updatingProduct));
    try {
      final productForUpdate = event.product;
      final updatedProduct = await productRepository.update(
        model: productForUpdate,
      );
      final productIndex = state.products.indexWhere(
        (element) => element.id == productForUpdate.id,
      );

      final products = List.of(state.products)
        ..removeAt(productIndex)
        ..insert(productIndex, updatedProduct);

      emit(
        state.copyWith(
          status: () => ProductsStatus.productUpdated,
          products: () => products,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: () => ProductsStatus.productUpdateError));
    }
  }

  FutureOr<void> _filterChange(
    FilterProductsEvent event,
    Emitter<ProductsState> emit,
  ) {
    emit(
      state.copyWith(
        filter: () => event.newFilterValue,
      ),
    );
  }
}
