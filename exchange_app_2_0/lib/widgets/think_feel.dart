import 'package:flutter/material.dart';

class ThinkFeel extends StatelessWidget {
  Color? color;
  String? buttonType;
  Function()? onPressed;
  double width;
  double height;
  Icon icon;

  ThinkFeel(
      {required this.color,
        required this.buttonType,
        required this.onPressed,
        required this.width,
        required this.height,
        required this.icon});

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
          child: Row(
            children: <Widget>[
              Text(
                buttonType!,
                style: const TextStyle(color: Colors.black),
              ),
              icon
            ],
          ),
        ),
      ),
    );
  }
}