import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Model/PhoneAuth_Model.dart';

class PhoneAuthViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneAuthModel _phoneAuthModel = PhoneAuthModel.initial();
  bool _isCodeSent = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isCodeSent => _isCodeSent;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PhoneAuthModel get phoneAuthModel => _phoneAuthModel;

  // Update phone number in the model
  void updatePhoneNumber(String phoneNumber) {
    _phoneAuthModel = _phoneAuthModel.copyWith(phoneNumber: "+2" + phoneNumber);
    notifyListeners();
  }

  // Method to send OTP to the provided phone number
  Future<void> sendOtp() async {
    if (!_phoneAuthModel.isValidPhoneNumber()) {
      _setErrorMessage("Invalid phone number");
      return;
    }

    _setLoading(true);

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneAuthModel.phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
    );

    _setLoading(false);
  }

  // Method to verify the OTP entered by the user
  Future<void> verifyOtp(String otp) async {
    _phoneAuthModel = _phoneAuthModel.copyWith(otp: otp);

    if (!_phoneAuthModel.isValidOtp()) {
      _setErrorMessage("Invalid OTP");
      return;
    }

    _setLoading(true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _phoneAuthModel.verificationId,
        smsCode: _phoneAuthModel.otp,
      );

      await _auth.signInWithCredential(credential);
      _clearErrorMessage();
    } catch (e) {
      _setErrorMessage("OTP verification failed: $e");
    }

    _setLoading(false);
  }

  // Called when verification is automatically completed (usually for auto-retrieved OTPs)
  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      _clearErrorMessage();
      notifyListeners();
    } catch (e) {
      _setErrorMessage("Verification failed: $e");
    }
  }

  // Called when verification fails (e.g., invalid phone number)
  void _onVerificationFailed(FirebaseAuthException e) {
    _setErrorMessage("Verification failed: ${e.message}");
  }

  // Called when the OTP is successfully sent
  void _onCodeSent(String verificationId, int? resendToken) {
    _phoneAuthModel = _phoneAuthModel.copyWith(verificationId: verificationId);
    _isCodeSent = true;
    notifyListeners();
  }

  // Called when code auto-retrieval times out
  void _onCodeAutoRetrievalTimeout(String verificationId) {
    _phoneAuthModel = _phoneAuthModel.copyWith(verificationId: verificationId);
    notifyListeners();
  }

  // Set error message and notify listeners
  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Clear error message and notify listeners
  void _clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  // Set loading state and notify listeners
  void _setLoading(bool value) {
    _isLoading = value;
    if(value) {
      CircularProgressIndicator();
    }
    notifyListeners();
  }

  // Reset the ViewModel to its initial state
  void reset() {
    _phoneAuthModel = PhoneAuthModel.initial();
    _isCodeSent = false;
    _isLoading = false;
    _clearErrorMessage();
  }
}
