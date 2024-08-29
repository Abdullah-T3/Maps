import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../View_Models/SignUp_ViewModel.dart';
class OtpView extends StatelessWidget {
  final String email; // Receive phone number through constructor
  late String otpCode; // OTP code entered by the user

  OtpView({required this.email});

  Widget buildIntroText() {
    return Column(
      children: [
        const Text(
          "Verify your Email",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: "Enter the 6 digit code sent to ",
            style: const TextStyle(fontSize: 20, color: Colors.black),
            children: [
              TextSpan(
                text: email,
                style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCodeField(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.grey.shade200,
          borderWidth: 2,
          inactiveBorderWidth: 2,
          activeColor: Colors.blue,
          inactiveColor: Colors.blue,
          selectedColor: Colors.blue,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }

  Widget buildVerifyButton(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,
        ),
        child: const Text(
          "Verify",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () async {


        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildIntroText(),
            buildCodeField(context),
              buildVerifyButton(context),
          ],
        ),
      ),
    );
  }
}
