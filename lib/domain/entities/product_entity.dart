import 'package:shopping/domain/entities/entity.dart';

class Product extends Entity {
  Product({
    required super.id,
    required this.name,
    this.unit = 'u',
    this.increment = 1.0,
    this.description,
  });

  factory Product.fromJson({required Map<String, dynamic> json}) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final description = json['description'] as String?;
    final unit = json['unit'] as String;
    final increment = json['increment'] as num;

    return Product(
      id: id,
      name: name,
      unit: unit,
      increment: increment.toDouble(),
      description: description,
    );
  }

  final String name;
  final String? description;
  final String unit;
  final double increment;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'unit': unit,
      'increment': increment,
    };
  }

  @override
  String toString() {
    return 'Product: $id, $name, $description, $unit, $increment';
  }
}
