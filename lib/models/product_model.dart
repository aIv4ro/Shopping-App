class Product {
  const Product({required this.id, required this.name, this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final description = json['description'] as String;

    return Product(
      id: id,
      name: name,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  final String id;
  final String name;
  final String? description;
}
