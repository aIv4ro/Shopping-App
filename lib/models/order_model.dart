import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/user_model.dart';

class Order {
  const Order({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final fromUserJson = json['fromUser'] as Map<String, dynamic>;
    final toUserJson = json['toUser'] as Map<String, dynamic>;
    final orderProductsJson = json['products'] as List<Map<String, dynamic>>;

    return Order(
      id: id,
      fromUser: User.fromJson(fromUserJson),
      toUser: User.fromJson(toUserJson),
      orderProducts: orderProductsJson.map(OrderProduct.fromJson).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromUser': fromUser.id,
      'toUser': toUser.id,
      'products': orderProducts.map((orderProduct) {
        return orderProduct.toJson();
      }).toList(),
    };
  }

  final String id;
  final User fromUser;
  final User toUser;
  final List<OrderProduct> orderProducts;
}
