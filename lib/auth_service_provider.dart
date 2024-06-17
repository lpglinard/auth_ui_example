import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;

  AuthService() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get isAuthenticated => _user != null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }


}