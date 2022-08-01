import 'package:shopping/models/product_model.dart';

class OrderProduct {
  const OrderProduct({required this.product, required this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    final product = Product.fromJson(json['product'] as Map<String, dynamic>);
    final quantity = json['quantity'] as double;

    return OrderProduct(
      product: product,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.id,
      'quantity': quantity,
    };
  }

  final Product product;
  final double quantity;
}
