import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/Views/Verfcation_View.dart';

import 'Constans/Strings.dart';
import 'Views/SearchHistory_View.dart';
import 'Views/SignIn_View.dart';
import 'Views/SignIn_withPhon_View.dart';
import 'Views/SignUp_View.dart';
import 'Views/homePage_View.dart';

class Approutes {
  Route ?onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInRoute:
        return MaterialPageRoute(builder: (context) =>  SigninView());
      case signUpRoute:
        return MaterialPageRoute(builder: (context) =>  SignUpView());
      case signInRouteWithPhone:
        return MaterialPageRoute(builder: (context) =>  SigninWithphonView());
      case verificationView:
        return MaterialPageRoute(builder: (context) =>  VerificationView());
      case homeRoute:
        return MaterialPageRoute(builder: (context) =>  HomepageView());
      case markHistoryRoute:
        return MaterialPageRoute(builder: (context) =>  SearchHistoryView());

    }
  }

}