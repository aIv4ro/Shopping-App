import 'package:shopping/domain/entities/entity.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/domain/entities/user_entity.dart';

class Order extends Entity {
  Order({
    required super.id,
    required this.fromUser,
    required this.toUser,
    required this.products,
  });

  factory Order.fromJson({required Map<String, dynamic> json}) {
    final id = json['id'] as String;
    final fromUser = json['fromUser'] as Map<String, dynamic>;
    final toUser = json['toUser'] as Map<String, dynamic>;
    final products = List<Map<String, dynamic>>.from(json['products'] as List);

    return Order(
      id: id,
      fromUser: User.fromJson(json: fromUser),
      toUser: User.fromJson(json: toUser),
      products: products.map((product) {
        return Product.fromJson(json: product);
      }).toList(),
    );
  }

  final User fromUser;
  final User toUser;
  final List<Product> products;

  @override
  Map<String, dynamic> toJson() {
    return {
      'fromUser': fromUser.toJson(),
      'toUser': toUser.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
