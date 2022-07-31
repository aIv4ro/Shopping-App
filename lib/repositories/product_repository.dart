import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/product_model.dart';

class ProductRepository {
  final firestore = FirebaseFirestore.instance;
  static const collectionName = 'products';

  Future<List<Product>> findAllProducts() async {
    final querySnapshot = await firestore.collection(collectionName).get();
    final products = querySnapshot.docs
        .map((doc) => Product.fromJson({'id': doc.id, ...doc.data()}))
        .toList();

    return products;
  }

  Future<Product> createProduct(String name, String description) async {
    final newDocRef = await firestore.collection(collectionName).add({
      'name': name,
      'description': description,
    });

    final newDoc = await newDocRef.get();

    return Product.fromJson({'id': newDoc.id, ...?newDoc.data()});
  }
}
