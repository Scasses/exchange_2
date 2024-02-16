import 'package:flutter/material.dart';

class OpposingViews extends StatefulWidget {
  const OpposingViews({Key? key}) : super(key: key);

  @override
  State<OpposingViews> createState() => _OpposingViewsState();
}

class _OpposingViewsState extends State<OpposingViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Opposing Views'),
      ),
    );
  }
}