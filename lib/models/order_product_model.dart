import 'package:shopping/models/product_model.dart';

class OrderProduct {
  OrderProduct({
    required this.product,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'] as Map<String, dynamic>;
    final quantity = json['quantity'] as double;

    return OrderProduct(
      product: Product.fromJson(productJson),
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
  double quantity;
}
