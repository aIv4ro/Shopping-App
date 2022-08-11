import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/order_model.dart';
import 'package:shopping/models/order_product_model.dart';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/firebase/product_repository.dart';
import 'package:shopping/repositories/firebase/user_repository.dart';
import 'package:shopping/repositories/repository.dart';

class OrderRepository extends ModelRepository<Order> {
  final firestore = FirebaseFirestore.instance;
  static const collectionPath = 'orders';

  Future<Order> createOrder({
    required User fromUser,
    required User toUser,
    List<OrderProduct> orderProducts = const [],
  }) async {
    final orderJson = {
      'fromUser': fromUser.id,
      'toUser': toUser.id,
      'orderProducts': orderProducts.map((orderProduct) {
        return orderProduct.toJson();
      }).toList(),
    };

    final doc = await firestore
        .collection(collectionPath)
        .add(orderJson)
        .then((value) => value.get());

    final order = await findOrderById(doc.id);

    return order;
  }

  Future<Order> findOrderById(String id) async {
    final doc = await firestore.collection(collectionPath).doc(id).get();
    final docData = doc.data() ?? {};
    final toUserRef = docData['fromUser'] as String;
    final fromUserRef = docData['toUser'] as String;
    final orderProductsRefs =
        docData['orderProducts'] as List<Map<String, dynamic>>;

    Future<Map<String, dynamic>> findUserById(String userRef) {
      return firestore.collection(UserRepository.path).doc(userRef).get().then(
            (value) => {'id': value.id, ...?value.data()},
          );
    }

    final futureToUser = findUserById(toUserRef);
    final futureFromUser = findUserById(fromUserRef);

    final futuresResult = await Future.wait([
      futureToUser,
      futureFromUser,
      Future.wait(
        orderProductsRefs.map((orderProductRef) async {
          final productRef = orderProductRef['product'] as String;
          final productQuantity = orderProductRef['quantity'] as double;
          final productDoc = await firestore
              .collection(ProductRepository.path)
              .doc(productRef)
              .get();

          productDoc.data();

          return {
            'quantity': productQuantity,
            'product': {'id': productDoc.id, ...?productDoc.data()}
          };
        }).toList(),
      ),
    ]);

    final toUserJson = futuresResult[0] as Map<String, dynamic>;
    final fromUserJson = futuresResult[1] as Map<String, dynamic>;
    final orderProductsJson = futuresResult[2] as List<Map<String, dynamic>>;

    final orderJson = {
      'id': doc.id,
      'fromUser': fromUserJson,
      'toUser': toUserJson,
      'orderProducts': orderProductsJson,
    };

    return Order.fromJson(orderJson);
  }

  Future<List<Order>> findAllOrders() async {
    final querySnapshot = await firestore.collection(collectionPath).get();
    final orders = await Future.wait(
      querySnapshot.docs.map((doc) async {
        final orderId = doc.id;
        final docData = doc.data();

        final fromUserRef = docData['fromUser'] as String;
        final toUserRef = docData['toUser'] as String;
        final orderProducts =
            docData['orderProducts'] as List<Map<String, dynamic>>;

        Future<Map<String, dynamic>> findUserById(String userRef) {
          return firestore
              .collection(UserRepository.path)
              .doc(userRef)
              .get()
              .then(
                (value) => {'id': value.id, ...?value.data()},
              );
        }

        final futureToUser = findUserById(toUserRef);
        final futureFromUser = findUserById(fromUserRef);

        final futuresResult = await Future.wait([
          futureToUser,
          futureFromUser,
          Future.wait(
            orderProducts.map((orderProduct) async {
              final productRef = orderProduct['product'] as String;
              final productQuantity = orderProduct['quantity'] as double;
              final productDoc = await firestore
                  .collection(ProductRepository.path)
                  .doc(productRef)
                  .get();

              productDoc.data();

              return {
                'quantity': productQuantity,
                'product': {'id': productDoc.id, ...?productDoc.data()}
              };
            }).toList(),
          )
        ]);

        final toUserJson = futuresResult[0] as Map<String, dynamic>;
        final fromUserJson = futuresResult[1] as Map<String, dynamic>;
        final productsJson = futuresResult[2] as List<Map<String, dynamic>>;

        return Order.fromJson({
          'id': orderId,
          'toUser': toUserJson,
          'fromUser': fromUserJson,
          'product': productsJson
        });
      }),
    );

    return orders;
  }

  @override
  FutureOr<Order> create({required Order model}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> delete({required String id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<List<Order>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  FutureOr<Order> findById({required String id}) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  FutureOr<Order> update({required Order model}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
