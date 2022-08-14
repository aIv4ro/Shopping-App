import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required this.productRepository,
  }) : super(const ProductsState()) {
    on<LoadNextPageEvent>(_loadNextPage);
    on<DeleteProductEvent>(_deleteProduct);
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
}
