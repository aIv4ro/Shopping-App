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
      return element.name.contains(filter ?? '');
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
      status: status != null ? status() : this.status,
      products: products != null ? products() : this.products,
      filter: filter != null ? filter() : this.filter,
      offset: offset != null ? offset() : this.offset,
      hasReachedMax:
          hasReachedMax != null ? hasReachedMax() : this.hasReachedMax,
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
