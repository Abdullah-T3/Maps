import 'package:flutter/material.dart';
import 'package:maps/Responsive/UiComponanets/InfoWidget.dart';
import 'package:provider/provider.dart';
import '../Comonants/Custom_textFeild.dart';
import '../Constans/Strings.dart';
import '../Model/SignUp_Model.dart';
import '../Responsive/models/DeviceInfo.dart';
import '../View_Models/SignUp_ViewModel.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool ispressed = true;

  Widget buildTopText() {
    return const Column(children: [
      Text(
        "Welcome To Our App",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);

    return Infowidget(builder: (BuildContext context, Deviceinfo deviceinfo) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceinfo.screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: deviceinfo.screenHeight * 0.1,
                  ),
                  buildTopText(),
                  SizedBox(
                    height: deviceinfo.screenHeight * 0.08,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:(value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      if (!value.contains(".com")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfeild(
                    validator:   (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password is too short";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: ispressed,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ispressed = !ispressed;
                          });
                        },
                        icon: ispressed
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.remove_red_eye),
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfeild(
                    validator:   (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password is too short";
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    obscureText: ispressed,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ispressed = !ispressed;
                          });
                        },
                        icon: ispressed
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.remove_red_eye),
                      ),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: deviceinfo.screenHeight * 0.05),
                    child: Container(
                      width: deviceinfo.screenWidth * 0.8,
                      height: deviceinfo.screenHeight * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                            deviceinfo.screenWidth * 0.05),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          final signUpModel = SignUpModel(
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                          );

                          try {
                            await signUpViewModel.signUp(signUpModel);
                            if (signUpModel.isValid()) {
                              Navigator.pushNamed(context, otbView);
                            }
                            else {
                              // Handle sign-up errors
                              print("Invalid sign-up data");
                            }

                          } catch (e) {
                            // Handle sign-up errors
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceinfo.screenWidth * 0.05),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
