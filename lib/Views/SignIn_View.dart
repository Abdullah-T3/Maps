import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Comonants/Custom_textFeild.dart';
import '../Constans/Strings.dart';
import '../Responsive/UiComponanets/InfoWidget.dart';
import '../Responsive/models/DeviceInfo.dart';
import '../View_Models/Auth_ViewModel.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  bool ispressed = true;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final GlobalKey formkey = GlobalKey<FormState>();

  Widget buildIntroText() {
    return const Column(
      children: [
        Text(
          "Welcome Back!",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 20),
        Text(
          "Sign in to continue",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Infowidget(
      builder: (BuildContext context, Deviceinfo deviceinfo) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Form(
                  key: formkey,
                  child: SizedBox(
                    height: deviceinfo.screenHeight,
                    width: deviceinfo.screenWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceinfo.localWidth * 0.03),
                      child: Column(
                        children: [
                          buildIntroText(),
                          SizedBox(
                            height: deviceinfo.localHeight * 0.1,
                          ),
                          CustomTextfeild(
                              hint: "Email",
                              obscureText: false,
                              icon: Icons.email,
                              controller: emailcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Email";
                                }
                                return null;
                              }),
                          SizedBox(
                            height: deviceinfo.localHeight * 0.03,
                          ),
                          CustomTextfeild(
                            icon: Icons.password,
                            controller: passwordcontroller,
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
                              prefixIcon: const Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceinfo.localWidth * 0.1),
                            child: Image.asset("assets/images/desk.png"),
                          ),
                          SizedBox(
                            height: deviceinfo.localHeight * 0.07,
                            width: deviceinfo.localWidth * 0.8,
                            child: MaterialButton(
                              onPressed: () async {

                                await authViewModel.signIn(emailcontroller.text,
                                    passwordcontroller.text);

                                if(authViewModel.state == AuthState.loading){
                                  const CircularProgressIndicator();
                                }
                                if (authViewModel.state == AuthState.success) {
                                  Navigator.pushReplacementNamed(
                                      context, homeRoute);
                                } else if (authViewModel.state == AuthState.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Invalid Email or Password")));
                                }
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:const Text(
                                "Sign In",
                                style:  TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Sign in With Phone Number",
                                style: TextStyle(color: Colors.black),
                              ),
                              IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             SigninWithphonView()));
                                  },
                                  icon: const Icon(Icons.phone_android,color: Colors.grey,))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, signUpRoute);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                            ],
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
      },
    );
  }
}
