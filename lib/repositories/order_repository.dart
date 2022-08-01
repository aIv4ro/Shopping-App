import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/order_model.dart';
import 'package:shopping/repositories/product_repository.dart';
import 'package:shopping/repositories/user_repository.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance;
  static const collectionPath = 'orders';

  Future<List<Order>> findAllOrders() async {
    final querySnapshot = await firestore.collection(collectionPath).get();
    final orders = querySnapshot.docs.map((doc) async {
      final orderId = doc.id, userRef = doc.data()['user'] as String;
      final productsRef = doc.data()['products'] as List;

      final userDoc = await firestore
          .collection(UserRepository.collectionName)
          .doc(userRef)
          .get();

      final user = {
        'id': userDoc.id,
        ...?userDoc.data(),
      };

      Future<Map> findProductById(String productRef) async {
        final productDoc = await firestore
            .collection(ProductRepository.collectionName)
            .doc(productRef)
            .get();

        return {'id': productDoc.id, ...?productDoc.data()};
      }

      final products = [
        for (final productRef in productsRef)
          await findProductById(productRef as String)
      ];

      return Order.fromJson({
        'id': orderId,
        'user': user,
        'products': products,
      });
    });

    return [];
  }
}
