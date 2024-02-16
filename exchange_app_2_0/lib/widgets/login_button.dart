import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  Color? color;
  String? title;
  Function()? onPressed;
  double? width;
  double? height;

  LoginButton(
      {required this.color,
        required this.title,
        required this.onPressed,
        required this.width,
        required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        elevation: 10.0,
        color: color,
        child: MaterialButton(
          elevation: 20.0,
          minWidth: width,
          height: height,
          onPressed: onPressed,
          child: Text(
            title!,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}