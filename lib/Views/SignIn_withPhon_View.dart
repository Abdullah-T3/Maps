import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Colors.dart';
import '../Responsive/UiComponanets/InfoWidget.dart';
import '../Comonants/Custom_textFeild.dart';
import '../Responsive/models/DeviceInfo.dart';
import '../View_Models/PhoneAuth_ViewModel.dart';
import 'Verfcation_View.dart';

class SigninWithphonView extends StatelessWidget {
  // Removed late keyword and use a controller instead
  final TextEditingController phoneController = TextEditingController();

  SigninWithphonView({super.key});

  Widget buildTopText() {
    return const Column(children: [
      Text(
        "What is your phone number?",
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      SizedBox(height: 20),
      Text(
        "Enter your phone number to continue",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ]);
  }

  Widget buildTextField() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              height: 50,
              padding:const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColors.lightGrey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${generateRandomFlag()}+20',
                  style: const TextStyle(letterSpacing: 2, fontSize: 24),
                ),
              ),
            )),
       const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextfeild(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  }
                  if (value.length != 11) {
                    return "Wrong phone number";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                hint: "Phone number",
                icon: Icons.phone,
                controller: phoneController,
                obscureText: false),
          ),
        )
      ],
    );
  }

  String generateRandomFlag() {
    String code = "eg";
    String flag = code.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    final phoneAuthViewModel = Provider.of<PhoneAuthViewModel>(context);
    return Infowidget(builder: (BuildContext context, Deviceinfo deviceinfo) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              physics:const NeverScrollableScrollPhysics(),
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        buildTopText(),
                        SizedBox(
                          height: deviceinfo.localHeight * 0.1,
                        ),
                        buildTextField(),
                        SizedBox(
                          height: deviceinfo.localHeight * 0.46,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              width: deviceinfo.screenWidth * 0.4,
                              height: deviceinfo.screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  final phoneNumber = phoneController.text;
                                  try {
                                    phoneAuthViewModel.updatePhoneNumber(phoneNumber);
                                    await phoneAuthViewModel.sendOtp();
                                    // If sendOtp() completes successfully, do something
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VerificationView(
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    // Handle any errors that occur during the sendOtp() call
                                    print('Error sending OTP: $e');
                                  }


                                },
                                child:const Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
