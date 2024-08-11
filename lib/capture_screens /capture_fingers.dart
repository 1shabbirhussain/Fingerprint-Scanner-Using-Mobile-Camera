import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:biopassid_fingerprint_sdk/biopassid_fingerprint_sdk.dart';

class FingerCapturePage extends StatefulWidget {
  const FingerCapturePage({super.key});

  @override
  _FingerCapturePageState createState() => _FingerCapturePageState();
}

class _FingerCapturePageState extends State<FingerCapturePage> {
  late FingerprintController controller;
  List<Uint8List> capturedImages = [];

  @override
  void initState() {
    super.initState();
    final config = FingerprintConfig(
      licenseKey: 'ZUGZ-CHWQ-2KJR-PQFI',
      outputType: FingerprintOutputType.captureAndSegmentation,
    );
    controller = FingerprintController(
      config: config,
      onFingerCapture: (images, error) {
        if (error != null) {
          print('onFingerCaptured: $error');
        } else {
          print('onFingerCaptured: $images ${images[0][0]}');
          setState(() {
            capturedImages = images;
          });
        }
      },
      onStatusChanged: (FingerprintCaptureState state) {
        print('onStatusChanged: $state');
      },
      onFingerDetected: (List<Rect> fingerRects) {
        print('onFingerDetected: $fingerRects');
      },
    );
  }

  void takeFingerprint() async {
    await controller.takeFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Fingers'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: takeFingerprint,
              child: const Text('Capture Fingers'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: capturedImages.length,
              itemBuilder: (context, index) {
                print("Image at Index :$index:${capturedImages[index]}");
                return Container(
                  color: Colors.orange,
                  child: Image.memory(capturedImages[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
