import 'package:flutter/material.dart';
import 'package:homco/screen/splash/splashmain.dart';

void main() {
  runApp(const homco());
}

class homco extends StatelessWidget {
  const homco({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashMain(),
    );
  }
}
