import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../Responsive/UiComponanets/InfoWidget.dart';
import '../Responsive/models/DeviceInfo.dart';
import '../View_Models/Auth_ViewModel.dart';


class VerificationView extends StatelessWidget {
  late String email; // Receive phone number through constructor
// OTP code entered by the user
  TextEditingController emailController = TextEditingController();

  Widget buildIntroText() {
    return Infowidget(builder: (BuildContext context, Deviceinfo deviceInfo) {
      return Column(
        children: [
          Text(
            "Verify your Email",
            style: TextStyle(
                fontSize: deviceInfo.screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: deviceInfo.screenHeight * 0.01),
          RichText(
            text: TextSpan(
              text: "Enter yor Email to send verification mail to ",
              style: TextStyle(
                  fontSize: deviceInfo.screenWidth * 0.03, color: Colors.black),
              children: [
                TextSpan(
                  text: email,
                  style: TextStyle(
                      fontSize: deviceInfo.screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget buildEmailField(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Infowidget(builder: (BuildContext context, Deviceinfo deviceInfo) {
      return TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: const InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
    });
  }

  Widget buildVerifyButton(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
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
          final code = emailController.text;

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildIntroText(),
            buildEmailField(context),
            buildVerifyButton(context),
          ],
        ),
      ),
    );
  }
}
