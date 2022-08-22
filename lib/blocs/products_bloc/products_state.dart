import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/product_entity.dart';

enum ProductsStatus {
  initialState,
  loadingPage,
  pageLoaded,
  deletingProduct,
  productDeleted,
  productDeletionError,
  updatingProduct,
  productUpdated,
  productUpdateError,
  creatingProduct,
  productCreated,
  productCreationError
}

class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initialState,
    this.products = const [],
    this.filter,
    this.offset = 0,
    this.limit = 10,
    this.hasReachedMax = false,
  });

  final ProductsStatus status;
  final List<Product> products;
  final String? filter;
  final int offset;
  final int limit;
  final bool hasReachedMax;
  List<Product> get filteredProducts {
    return products.where((element) {
      return element.name.toLowerCase().contains(filter ?? '');
    }).toList();
  }

  ProductsState copyWith({
    ProductsStatus Function()? status,
    List<Product> Function()? products,
    String? Function()? filter,
    int Function()? offset,
    bool Function()? hasReachedMax,
  }) {
    return ProductsState(
      status: status?.call() ?? this.status,
      products: products?.call() ?? this.products,
      filter: filter?.call() ?? this.filter,
      offset: offset?.call() ?? this.offset,
      hasReachedMax: hasReachedMax?.call() ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        offset,
        limit,
        hasReachedMax,
        filter,
      ];
}
