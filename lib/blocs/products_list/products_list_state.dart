import 'package:equatable/equatable.dart';
import 'package:shopping/domain/entities/product_entity.dart';

enum ProductsListStatus { initialStatus, loadingPage, pageLoaded }

class ProductsListState extends Equatable {
  const ProductsListState({
    this.status = ProductsListStatus.initialStatus,
    this.products = const [],
    this.filter = '',
    this.offset = 0,
    this.hasReachedMax = false,
  });

  static const limit = 10;
  final ProductsListStatus status;
  final List<Product> products;
  final String filter;
  final int offset;
  final bool hasReachedMax;

  List<Product> get productsFilter {
    return products.where((product) {
      return product.name.toLowerCase().contains(filter);
    }).toList();
  }

  ProductsListState copyWith({
    ProductsListStatus Function()? status,
    List<Product> Function()? products,
    String Function()? filter,
    int Function()? offset,
    bool Function()? hasReachedMax,
  }) {
    return ProductsListState(
      status: status?.call() ?? this.status,
      products: products?.call() ?? this.products,
      filter: filter?.call() ?? this.filter,
      offset: offset?.call() ?? this.offset,
      hasReachedMax: hasReachedMax?.call() ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, products, filter, offset, hasReachedMax];
}
