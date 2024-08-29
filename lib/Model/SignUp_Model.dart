class SignUpModel {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  // Check if passwords match
  bool isPasswordMatch() {
    return password == confirmPassword;
  }

  // Validate the input data
  bool isValid() {
    return email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && isPasswordMatch();
  }
}
