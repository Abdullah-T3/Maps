import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constans/Strings.dart';
import '../View_Models/Auth_ViewModel.dart';
import 'SignIn_View.dart';

class HomepageView extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final authViewModel =
    Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await authViewModel.signOut();
          if(authViewModel.state == AuthState.success){
            Navigator.pushReplacementNamed(context, signInRoute);
          }else if(authViewModel.state == AuthState.loading){
            CircularProgressIndicator();
          }

        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
