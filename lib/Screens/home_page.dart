import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Printer Demo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            printDoc();
          },
          child: const Text("Print"),
        ),
      ),
    );
  }

  Future<void> printDoc() async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(children: [
              pw.Text("vijaycreations",
                  style: const pw.TextStyle(fontSize: 35)),
                  pw.Container(color: PdfColor(0.2, 0.4, 0.4, 0.1),child:pw.Text("hai")),
              pw.Divider(),
              pw.Text("Hello World")
            ]),
          );
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
