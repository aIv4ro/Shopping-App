import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/blocs/products_list/products_list_state.dart';
import 'package:shopping/domain/repositories/i_product_repository.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc({
    required this.productRepository,
  }) : super(const ProductsListState()) {
    on<LoadNextPageEvent>(_loadNextPage);
    on<RemoveProductEvent>(_removeProductEvent);
    on<AddProductEvent>(_addProductEvent);
  }

  final IProductRepository productRepository;

  FutureOr<void> _loadNextPage(
    LoadNextPageEvent event,
    Emitter<ProductsListState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductsListStatus.loadingPage));

    final newProducts = await productRepository.search(
      offset: state.offset,
      limit: ProductsListState.limit,
    );

    emit(
      state.copyWith(
        status: () => ProductsListStatus.pageLoaded,
        products: () => List.of(state.products)..addAll(newProducts),
        offset: () => state.offset + ProductsListState.limit,
        hasReachedMax: () => newProducts.isEmpty,
      ),
    );
  }

  FutureOr<void> _removeProductEvent(
    RemoveProductEvent event,
    Emitter<ProductsListState> emit,
  ) async {
    emit(
      state.copyWith(
        products: () => List.of(state.products)
          ..removeWhere((element) => element.id == event.product.id),
      ),
    );
  }

  FutureOr<void> _addProductEvent(
    AddProductEvent event,
    Emitter<ProductsListState> emit,
  ) {
    emit(
      state.copyWith(
        products: () => List.of(state.products)
          ..add(event.product)
          ..sort((a, b) => a.name.compareTo(b.name)),
      ),
    );
  }
}
