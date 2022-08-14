import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/product_entity.dart';

enum ProductsStatus {
  initialState,
  loadingPage,
  pageLoaded,
  deletingProduct,
  productDeleted,
  productDeletionError
}

class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initialState,
    this.products = const [],
    this.offset = 0,
    this.limit = 10,
    this.hasReachedMax = false,
  });

  final ProductsStatus status;
  final List<Product> products;
  final int offset;
  final int limit;
  final bool hasReachedMax;

  ProductsState copyWith({
    ProductsStatus Function()? status,
    List<Product> Function()? products,
    int Function()? offset,
    bool Function()? hasReachedMax,
  }) {
    return ProductsState(
      status: status != null ? status() : this.status,
      products: products != null ? products() : this.products,
      offset: offset != null ? offset() : this.offset,
      hasReachedMax:
          hasReachedMax != null ? hasReachedMax() : this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, products, offset, limit, hasReachedMax];
}
