import 'dart:io';

import 'package:flutter/material.dart';

class CapturedFiles extends StatelessWidget {
  const CapturedFiles({super.key,required this.file1, required this.file2});
final File file1;
final File file2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.file(file1),
        Image.file(file2),

      ]),
    );
  }
}