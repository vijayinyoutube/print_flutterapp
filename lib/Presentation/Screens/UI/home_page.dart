import 'package:flutter/material.dart';
import 'package:print_flutterapp/Presentation/Components/image_builder.dart';
import 'package:print_flutterapp/Presentation/Components/spacer.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widgets/invoice_table.dart';
import '../Widgets/save_btn.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.00),
          child: Column(
            children: const [
              Text("vijaycreations",
                  style:
                      TextStyle(fontSize: 25.00, fontWeight: FontWeight.bold)),
              HeightSpacer(myHeight: 10.00),
              Divider(),
              Align(
                alignment: Alignment.topRight,
                child: ImageBuilder(
                  imagePath: "assets/Images/image.png",
                  imgWidth: 250,
                  imgheight: 250,
                ),
              ),
              InvoiceBuilder(),
              HeightSpacer(myHeight: 15.00),
              Text(
                "Thanks for choosing our service!",
                style: TextStyle(color: Colors.grey, fontSize: 15.00),
              ),
              HeightSpacer(myHeight: 5.00),
              Text(
                "Contact the branch for any clarifications.",
                style: TextStyle(color: Colors.grey, fontSize: 15.00),
              ),
              HeightSpacer(myHeight: 15.00),
              SaveBtnBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/Images/image.png",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(25.00),
            child: pw.Column(children: [
              pw.Text("vijaycreations",
                  style: pw.TextStyle(
                      fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10.00),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Image(
                  image,
                  width: 250,
                  height: 250,
                ),
              ),
              pw.Column(
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.SizedBox(width: 5.5),
                      pw.Text(
                        "Invoice",
                        style: pw.TextStyle(
                            fontSize: 23.00, fontWeight: pw.FontWeight.bold),
                      )
                    ],
                  ),
                  pw.SizedBox(height: 10.00),
                  pw.Container(
                    color: PdfColor(255, 255, 250, 0.1),
                    width: double.infinity,
                    height: 36.00,
                    child: pw.Center(
                      child: pw.Text(
                        "Approvals",
                        style: pw.TextStyle(
                            color: PdfColor(255, 255, 250, 0.1),
                            fontSize: 20.00,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ),
                  for (var i = 0; i < 3; i++)
                    pw.Container(
                      color: i % 2 != 0
                          ? PdfColor(255, 255, 250, 0.1)
                          : PdfColor(255, 0, 250, 0.1),
                      width: double.infinity,
                      height: 36.00,
                      child: pw.Padding(
                        padding:
                            const pw.EdgeInsets.symmetric(horizontal: 25.0),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            i == 2
                                ? pw.Text(
                                    "Tax",
                                    style: pw.TextStyle(
                                        fontSize: 18.00,
                                        fontWeight: pw.FontWeight.bold),
                                  )
                                : pw.Text(
                                    "Item ${i + 1}",
                                    style: pw.TextStyle(
                                        fontSize: 18.00,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                            i == 2
                                ? pw.Text(
                                    "\$ 2.50",
                                    style: pw.TextStyle(
                                        fontSize: 18.00,
                                        fontWeight: pw.FontWeight.normal),
                                  )
                                : pw.Text(
                                    "\$ ${(i + 1) * 7}.00",
                                    style: pw.TextStyle(
                                        fontSize: 18.00,
                                        fontWeight: pw.FontWeight.normal),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                    child: pw.Container(
                      color: PdfColor(0, 255, 250, 0.1),
                      width: double.infinity,
                      height: 36.00,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            "\$ 23.50",
                            style: pw.TextStyle(
                              fontSize: 22.00,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor(255, 123, 250, 0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 15.00),
                  pw.Text(
                    "Thanks for choosing our service!",
                    style: pw.TextStyle(
                        color: PdfColor(255, 255, 250, 0.1), fontSize: 15.00),
                  ),
                  pw.SizedBox(height: 5.00),
                  pw.Text(
                    "Contact the branch for any clarifications.",
                    style: pw.TextStyle(
                        color: PdfColor(255, 255, 250, 0.1), fontSize: 15.00),
                  ),
                  pw.SizedBox(height: 15.00),
                ],
              )
            ]),
          );
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
