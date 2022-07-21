import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password,
    );
  }

  Future<void> registerUser(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}