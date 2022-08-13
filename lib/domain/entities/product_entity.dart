import 'package:shopping/domain/entities/entity.dart';

class Product extends Entity {
  Product({
    required super.id,
    required this.name,
    this.description,
  });

  factory Product.fromJson({required Map<String, dynamic> json}) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final description = json['description'] as String?;

    return Product(
      id: id,
      name: name,
      description: description,
    );
  }

  final String name;
  final String? description;

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }

  @override
  String toString() {
    return 'Product: $id, $name, $description';
  }
}
