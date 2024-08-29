import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/SignUp_Model.dart';
enum SignUpState {
  initial,
  loading,
  success,
  error,
}
class SignUpViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SignUpState _state = SignUpState.initial;

  SignUpState get state => _state;

  Future<void> signUp(SignUpModel signUpModel) async {
    if (!signUpModel.isValid()) {
      _state = SignUpState.error;
      notifyListeners();
      throw Exception("Invalid sign-up data");
    }

    _state = SignUpState.loading;
    notifyListeners();

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: signUpModel.email,
        password: signUpModel.password,
      );

      User? user = userCredential.user;

      // Send email verification
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        print('Verification email sent to ${user.email}');
      }

      _state = SignUpState.success;
      notifyListeners();
    } catch (e) {
      _state = SignUpState.error;
      notifyListeners();
      throw Exception('Sign-up failed: $e');
    }
  }
}