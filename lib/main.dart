import 'package:demo_project/capture_screens%20/capture_single_finger.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fingerprint Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SingleFingerCapturePage(),
    );
  }
}

