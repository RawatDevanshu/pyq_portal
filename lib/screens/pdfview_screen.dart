import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class CustomPdfView extends StatelessWidget {
  CustomPdfView({super.key, required this.filePath});
  String filePath;
  @override
  Widget build(BuildContext context) {
    print(File(filePath).existsSync());
    return Scaffold(
      appBar: AppBar(title: Text("PDF viewer")),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print("error: $error");
        },
      ),
    );
  }
}
