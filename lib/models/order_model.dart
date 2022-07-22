import 'package:shopping/models/product_model.dart';
import 'package:shopping/models/user_model.dart';

class Order {
  const Order({required this.id, required this.user, required this.products});

  factory Order.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final user = User.fromJson(json['user']);
    final products = (json['products'] as List<Map<String, dynamic>>)
        .map(Product.fromJson)
        .toList();

    return Order(
      id: id,
      user: user,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.id,
      'products': products.map((product) => product.id).toList(),
    };
  }

  final String id;
  final User user;
  final List<Product> products;
}
