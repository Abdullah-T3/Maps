import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps/AppRoutes.dart';
import 'package:provider/provider.dart';

import 'Constants/Strings.dart';
import 'View_Models/Auth_ViewModel.dart';
import 'View_Models/PhoneAuth_ViewModel.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => PhoneAuthViewModel()),
        ],
     child:  FlutterMaps( appRouter: Approutes(),),)
  );
}

class FlutterMaps extends StatelessWidget {
   const FlutterMaps({super.key, required this.appRouter});
  final Approutes appRouter;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: signInRoute ,
      onGenerateRoute: appRouter.onGenerateRoute,

    );
  }
}
