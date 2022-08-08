import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/repositories/repository.dart';

class ProductRepository extends Respository<Product> {
  final firestore = FirebaseFirestore.instance;
  static const path = 'products';

  @override
  Future<Product> create({required Product model}) async {
    final docRef = await firestore.collection(path).add({...model.toJson()});
    final doc = await docRef.get();

    return Product.fromJson({'id': doc.id, ...?doc.data()});
  }

  @override
  Future<List<Product>> findAll() async {
    final querySnapshot = await firestore.collection(path).get();
    final products = querySnapshot.docs.map((doc) {
      return Product.fromJson({'id': doc.id, ...doc.data()});
    }).toList();

    return products;
  }

  @override
  Future<Product> findById({required String id}) async {
    final doc = await firestore.collection(path).doc(id).get();
    return Product.fromJson({'id': doc.id, ...?doc.data()});
  }

  @override
  Future<Product> update({required Product model}) async {
    await firestore.collection(path).doc(model.id).update(model.toJson());
    return model;
  }

  @override
  Future<bool> delete({required String id}) {
    return firestore
        .collection(path)
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((err) => false);
  }
}
