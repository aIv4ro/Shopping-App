import 'package:shopping/domain/entities/entity.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';

class Order extends Entity {
  const Order({
    required super.id,
    required this.fromUser,
    required this.toUser,
    required this.orderProducts,
  });

  factory Order.fromJson({required Map<String, dynamic> json}) {
    final id = json['id'] as String;
    final fromUser = json['fromUser'] as Map<String, dynamic>;
    final toUser = json['toUser'] as Map<String, dynamic>;
    final orderProducts =
        List<Map<String, dynamic>>.from(json['orderProducts'] as List);

    return Order(
      id: id,
      fromUser: User.fromJson(json: fromUser),
      toUser: User.fromJson(json: toUser),
      orderProducts: orderProducts.map((orderProduct) {
        return OrderProduct.fromJson(json: orderProduct);
      }).toList(),
    );
  }

  static const empty = Order(
    id: '',
    fromUser: User.empty,
    toUser: User.empty,
    orderProducts: [],
  );

  final User fromUser;
  final User toUser;
  final List<OrderProduct> orderProducts;

  @override
  Map<String, dynamic> toJson() {
    return {
      'fromUser': fromUser.id,
      'toUser': toUser.id,
      'orderProducts': orderProducts.map((orderProduct) {
        return orderProduct.toJson();
      }).toList(),
    };
  }
}
