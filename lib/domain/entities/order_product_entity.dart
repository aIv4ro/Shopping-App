import 'package:shopping/domain/entities/entity.dart';
import 'package:shopping/domain/entities/product_entity.dart';

class OrderProduct extends Entity {
  OrderProduct({
    required super.id,
    required this.product,
    required this.quantity,
  });

  factory OrderProduct.fromJson({required Map<String, dynamic> json}) {
    final id = json['_id'] as String;
    final product = json['product'] as Map<String, dynamic>;
    final quantity = (json['quantity'] as int).toDouble();

    return OrderProduct(
      id: id,
      product: Product.fromJson(json: product),
      quantity: quantity,
    );
  }

  final Product product;
  final double quantity;

  @override
  Map<String, dynamic> toJson() {
    return {
      'product': product.id,
      'quantity': quantity,
    };
  }
}
