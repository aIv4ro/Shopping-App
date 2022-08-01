import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/user_model.dart';

class Order {
  const Order({
    required this.id,
    required this.user,
    required this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final userJson = json['user'] as Map<String, dynamic>;
    final orderProductsJson = json['products'] as List<Map<String, dynamic>>;

    return Order(
      id: id,
      user: User.fromJson(userJson),
      orderProducts: orderProductsJson.map(OrderProduct.fromJson).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.id,
      'products':
          orderProducts.map((orderProduct) => orderProduct.toJson()).toList(),
    };
  }

  final String id;
  final User user;
  final List<OrderProduct> orderProducts;
}
