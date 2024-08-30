import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  const CustomTextfeild(
      {super.key,
       this.hint,
       this.icon,
       this.controller,
      required this.obscureText, this.border, this.keyboardType,  this.validator, this.onsaved, this.decoration, });
  final FormFieldValidator<String>? validator;
  final void Function(String?)? onsaved;
  final String ?hint;
  final IconData? icon;
  final TextEditingController ?controller;
  final bool obscureText;   
  final OutlineInputBorder ?border;
  final TextInputType ?keyboardType;
  final InputDecoration ?decoration;
  @override 
  Widget build(BuildContext context) {  
    return TextFormField(
      
      onSaved: onsaved,
      validator: validator,
      keyboardType: keyboardType ,
      controller: controller, 
      obscureText: obscureText,
      decoration: decoration ?? InputDecoration(
        enabledBorder:  border,
        focusedBorder:  border,
        labelText: hint,
        labelStyle:  const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


 