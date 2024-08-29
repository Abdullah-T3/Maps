class PhoneAuthModel {
  final String phoneNumber;
  final String verificationId;
  final String otp;

  PhoneAuthModel({
    required this.phoneNumber,
    required this.verificationId,
    required this.otp,
  });

  // Factory method to create an empty PhoneAuthModel
  factory PhoneAuthModel.initial() {
    return PhoneAuthModel(
      phoneNumber: '',
      verificationId: '',
      otp: '',
    );
  }

  // Copy with method to update model fields
  PhoneAuthModel copyWith({
    String? phoneNumber,
    String? verificationId,
    String? otp,
  }) {
    return PhoneAuthModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      otp: otp ?? this.otp,
    );
  }

  // Validate phone number format (basic example)
  bool isValidPhoneNumber() {
    return phoneNumber.isNotEmpty && phoneNumber.length == 11;
  }

  // Validate OTP
  bool isValidOtp() {
    return otp.isNotEmpty && otp.length == 6;
  }
}
