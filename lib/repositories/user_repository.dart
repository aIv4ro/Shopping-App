import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/repositories/repository.dart';

class UserRepository extends Respository<User> {
  final firestore = FirebaseFirestore.instance;
  static const path = 'users';
  static User? currentUser;

  @override
  Future<User> create({required User model}) async {
    final docRef = await firestore.collection(path).add({...model.toJson()});
    final doc = await docRef.get();

    return User.fromJson({'id': doc.id, ...?doc.data()});
  }

  @override
  Future<List<User>> findAll() async {
    final querySnapshot = await firestore.collection(path).get();
    final users = querySnapshot.docs.map((doc) {
      final json = {'id': doc.id, ...doc.data()};
      return User.fromJson(json);
    }).toList();

    return users;
  }

  @override
  Future<User> findById({required String id}) async {
    final doc = await firestore.collection(path).doc(id).get();
    return User.fromJson({'id': doc.id, ...?doc.data()});
  }

  @override
  Future<User> update({required User model}) async {
    await firestore.doc(model.id).update(model.toJson());
    return model;
  }

  @override
  Future<bool> delete({required String id}) async {
    return firestore.collection(path).doc(id).delete().then((value) {
      return true;
    }).catchError((err) {
      return false;
    });
  }

  Future<List<String>> loadAllEmails() async {
    final querySnapshot = await firestore.collection(path).get();
    final emails = querySnapshot.docs
        .map((doc) => doc.data()['email'].toString())
        .toList();

    return emails;
  }

  Future<User> findUserByEmail(String email) async {
    final querySnapshot =
        await firestore.collection(path).where('email', isEqualTo: email).get();
    final doc = querySnapshot.docs.first;

    return User.fromJson({'id': doc.id, ...doc.data()});
  }
}
