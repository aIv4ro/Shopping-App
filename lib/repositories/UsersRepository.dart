import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/User.dart';

class UsersRepository {
  final firestore = FirebaseFirestore.instance;
  final collectionName = 'users';

  Future<List<User>> findAllUsers() async {
    final querySnapshot = await firestore.collection(collectionName).get();
    final users = querySnapshot.docs.map((doc) {
      final json = {
        'id': doc.id,
        ...doc.data()
      };

      return User.fromJson(json);
    }).toList();

    return users;
  }

  Future<List<String>> loadAllEmails() async {
    final querySnapshot = await firestore.collection(collectionName).get();
    final emails = querySnapshot.docs.map(
      (doc) => doc.data()['email'].toString()
    ).toList();

    return emails;
  }
}