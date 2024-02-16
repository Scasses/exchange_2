import 'package:flutter/material.dart';

class BubbleStories extends StatelessWidget {
  final String? text;
  final Function()? onDoubleTap;

  BubbleStories({required this.text, required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTap: onDoubleTap,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(text!, style: const TextStyle(color: Colors.black),),
        ],
      ),
    );
  }
}