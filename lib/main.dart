import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps/AppRoutes.dart';
import 'package:maps/Constants/Strings.dart';
import 'package:maps/Views/SearchHistory_View.dart';
import 'package:maps/Views/SignIn_View.dart';
import 'package:maps/Views/SignUp_View.dart';
import 'package:maps/Views/homePage_View.dart';
import 'package:provider/provider.dart';
import 'View_Models/Auth_ViewModel.dart';
import 'View_Models/PhoneAuth_ViewModel.dart';
 late String initialroute ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  FirebaseAuth.instance.authStateChanges().listen((user){
    if(user != null){
      initialroute = homeRoute;
    }else{
      initialroute = signInRoute;
    }
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => PhoneAuthViewModel()),
    ],
    child: FlutterMaps(),
  ));
}

class FlutterMaps extends StatelessWidget {
  const FlutterMaps({
    super.key,
  });
 
  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialroute,
 onGenerateRoute: Approutes().onGenerateRoute,
   onUnknownRoute: (RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => SigninView(),
    );
  }

    );
  }
}
