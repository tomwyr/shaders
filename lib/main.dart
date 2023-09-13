import 'package:flutter/material.dart';

import 'shaders/smooth_clip.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox.square(
            dimension: 300,
            child: SmoothClip(
              child: Image.asset(
                'assets/graph.png',
                color: Colors.deepOrange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
