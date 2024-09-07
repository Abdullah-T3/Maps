import 'package:flutter/material.dart';
import 'Constants/Strings.dart';
import 'Views/SearchHistory_View.dart';
import 'Views/SignIn_View.dart';
import 'Views/SignUp_View.dart';
import 'Views/homePage_View.dart';

class Approutes {
  Route ? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInRoute:
        return MaterialPageRoute(builder: (context) =>  const SigninView());
      case signUpRoute:
        return MaterialPageRoute(builder: (context) =>  const SignUpView());
      case homeRoute:
        return MaterialPageRoute(builder: (context) =>  const HomepageView());
      case markHistoryRoute:
        return MaterialPageRoute(builder: (context) =>  SearchHistoryView());

    }
    return null;
  }

}