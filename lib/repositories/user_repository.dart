import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/models/user_model.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  static const collectionName = 'users';

  static User? currentUser;

  Future<List<User>> findAllUsers() async {
    final querySnapshot = await firestore.collection(collectionName).get();
    final users = querySnapshot.docs.map((doc) {
      final json = {'id': doc.id, ...doc.data()};

      return User.fromJson(json);
    }).toList();

    return users;
  }

  Future<List<String>> loadAllEmails() async {
    final querySnapshot = await firestore.collection(collectionName).get();
    final emails = querySnapshot.docs
        .map((doc) => doc.data()['email'].toString())
        .toList();

    return emails;
  }

  Future<User> createUser(String email, String name, String surname) async {
    final newDocRef = await firestore.collection(collectionName).add({
      'email': email,
      'name': name,
      'surname': surname,
    });
    final newDoc =
        await firestore.collection(collectionName).doc(newDocRef.path).get();

    return User.fromJson({'id': newDoc.id, ...?newDoc.data()});
  }

  Future<User> findUserByEmail(String email) async {
    final querySnapShot = await firestore
        .collection(collectionName)
        .limit(1)
        .where('email', isEqualTo: email)
        .get();
    final doc = querySnapShot.docs.first;

    return User.fromJson({'id': doc.id, ...doc.data()});
  }
}
