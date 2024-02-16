import 'package:flutter/material.dart';







class UserBubble extends StatelessWidget {
  final String? username;
  final Function()? onDoubleTap;

  UserBubble(
      {required this.username,
        required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onDoubleTap: onDoubleTap,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      shape: BoxShape.rectangle,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                username!,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}