
import 'package:demo_project/capture_screens%20/capture_fingers.dart';
import 'package:demo_project/capture_screens%20/capture_single_finger.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fingerprint Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FingerCapturePage()),
                );
              },
              child: const Text('Capture 4 Fingers'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SingleFingerCapturePage()),
                );
              },
              child: const Text('Capture 1 finger only'),
            ),
          ],
        ),
      ),
    );
  }
}