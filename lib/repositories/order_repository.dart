import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/order_model.dart';
import 'package:shopping/repositories/product_repository.dart';
import 'package:shopping/repositories/user_repository.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance;
  static const collectionPath = 'orders';

  Future<List<Order>> findAllOrders() async {
    final querySnapshot = await firestore.collection(collectionPath).get();
    final orders = await Future.wait(
      querySnapshot.docs.map(
        (doc) async {
          final orderId = doc.id;
          final docData = doc.data();

          final userRef = docData['user'] as String;
          final orderProducts =
              docData['orderProducts'] as List<Map<String, dynamic>>;

          final futuresResult = await Future.wait([
            firestore
                .collection(UserRepository.collectionName)
                .doc(userRef)
                .get()
                .then(
              (value) {
                return {'id': value.id, ...?value.data()};
              },
            ),
            Future.wait(
              orderProducts.map(
                (orderProduct) async {
                  final productRef = orderProduct['product'] as String;
                  final productQuantity = orderProduct['quantity'] as double;
                  final productDoc = await firestore
                      .collection(ProductRepository.collectionName)
                      .doc(productRef)
                      .get();

                  productDoc.data();

                  return {
                    'quantity': productQuantity,
                    'product': {'id': productDoc.id, ...?productDoc.data()}
                  };
                },
              ).toList(),
            )
          ]);

          final userJson = futuresResult[0] as Map<String, dynamic>;
          final productsJson = futuresResult[1] as List<Map<String, dynamic>>;

          return Order.fromJson({
            'id': orderId,
            'user': {...userJson},
            'product': [...productsJson]
          });
        },
      ),
    );

    return orders;
  }
}
