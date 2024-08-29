import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/User_Model.dart';

enum AuthState { idle, loading, success, error }

class AuthViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;
  AuthState _state = AuthState.idle;
  String? _errorMessage;

  UserModel? get user => _user;
  AuthState get state => _state;
  String? get errorMessage => _errorMessage;

  // Method to sign in with email and password
  Future<void> signIn(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = UserModel.fromFirebaseUser(result.user!);
      _state = AuthState.success;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'Sign in failed: $e';
    }
    notifyListeners();
  }

  // Method to register with email and password
  Future<void> signUp(String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      _state = AuthState.error;
      _errorMessage = 'Passwords do not match';
      notifyListeners();
      return;
    }

    _state = AuthState.loading;
    notifyListeners();

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      result.user?.updateDisplayName(
        email.substring(0, email.indexOf('@')),
      );
      _user = UserModel.fromFirebaseUser(result.user!);
      _state = AuthState.success;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'Sign up failed: $e';
    }
    notifyListeners();
  }

  // Method to sign out
  Future<void> signOut() async {
    _state = AuthState.loading;
    notifyListeners();
    try {
      await _auth.signOut();
      _user = null;
      _state = AuthState.success;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'Sign out failed: $e';
    }
    notifyListeners();
  }

  // Check if user is already signed in
  void checkUserLoggedIn() {
    _state = AuthState.loading;
    notifyListeners();

    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _user = UserModel.fromFirebaseUser(currentUser);
      _state = AuthState.success;
    } else {
      _user = null;
      _state = AuthState.idle;
    }
    notifyListeners();
  }
}
