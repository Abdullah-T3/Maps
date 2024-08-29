import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constans/Strings.dart';
import 'View_Models/Auth_ViewModel.dart';
import 'View_Models/PhoneAuth_ViewModel.dart';
import 'View_Models/SignUp_ViewModel.dart';
import 'Views/SignIn_View.dart';
import 'Views/SignIn_withPhon_View.dart';
import 'Views/SignUp_View.dart';
import 'Views/homePage_View.dart';
import 'Views/otp_View.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => SignUpViewModel()),
          ChangeNotifierProvider(create: (_) => PhoneAuthViewModel()),
        ],
     child: FlutterMaps(),)
  );
}

class FlutterMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: authViewModel.user != null ? homeRoute : signInRoute,
      routes: {
        signInRoute: (context) => const SigninView(),
        signUpRoute: (context) => SignUpScreen(),
        homeRoute: (context) => HomepageView(),
        signInRouteWithPhone: (context) => SigninWithphonView(),
      },
    );
  }
}
