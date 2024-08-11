import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:sudhir_jwel_billing/model/billing_item.dart';

class InvoicePage extends StatelessWidget {
  final List<BillingItem> billingItems;
  final String buyerName;
  final String buyerContact;
  final String buyerAdhar;
  final String buyerAddress;
  final String buyerPan;

  const InvoicePage({
    super.key,
    required this.billingItems,
    required this.buyerName,
    required this.buyerContact,
    required this.buyerAdhar,
    required this.buyerAddress,
    required this.buyerPan,
  });

  // Generate a shorter unique invoice number
  String generateInvoiceNumber() {
    final timestamp = DateTime.now();
    final random = Random();
    final randomSuffix = random.nextInt(1000).toString().padLeft(3, '0');
    final formattedDate = DateFormat('yyMMdd').format(timestamp); // Format date as YYMMDD
    return '$formattedDate-$randomSuffix';
  }

  // Format date/time to 12-hour format
  String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy h:mm a ').format(dateTime); // Example: Aug 11, 2024 3:45 PM
  }

  Future<void> requestPermissions() async {
    final status = await [
      Permission.storage,
      Permission.manageExternalStorage, // For Android 11 and later
    ].request();

    if (status[Permission.storage]!.isGranted &&
        status[Permission.manageExternalStorage]!.isGranted) {
      print('Permissions granted');
    } else {
      print('Permissions denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final double imageWidth = screenWidth * 0.4;
    final double imageHeight = screenHeight * 0.12;
    final double spacing = screenHeight * 0.01;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Buyer Name: $buyerName"),
                      Text("Buyer Contact: $buyerContact"),
                      Text("Buyer Aadhar: $buyerAdhar"),
                      Text("Buyer Address: $buyerAddress"),
                      Text("Buyer PAN: $buyerPan"),
                      SizedBox(height: spacing),
                    ],
                  ),
                  SizedBox(width: 2,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("GSTN No : 27CKXPS9939M1ZK"),
                      Text("GST Type : SGST + CGST"),
                      Text("Date & Time : \n${formatDateTime(DateTime.now())}")
                    ],
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DataTable(
                    columnSpacing: screenWidth * 0.1,
                    dataRowMaxHeight: screenHeight * 0.2,
                    columns: const [
                      DataColumn(label: Text('Particulars')),
                      DataColumn(label: Text('Purity')),
                      DataColumn(label: Text('Gross Wt.')),
                      DataColumn(label: Text('Net Wt.')),
                      DataColumn(label: Text('Rate [ Per Gm ]')),
                      DataColumn(label: Text('Other Charges')),
                      DataColumn(label: Text('Making')),
                      DataColumn(label: Text('GST')),
                      DataColumn(label: Text('Total At.')),
                      DataColumn(label: Text('Gross At.')),
                    ],
                    rows: [
                      for (var item in billingItems)
                        DataRow(cells: [
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Item name : ${item.itemName}'),
                                SizedBox(height: spacing),
                                SizedBox(
                                  width: imageWidth,
                                  height: imageHeight,
                                  child: Image.file(
                                    File(item.itemImage),
                                    width: imageWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error, size: imageWidth);
                                    },
                                  ),
                                ),
                                SizedBox(height: spacing),
                                Text('Pcs : ${item.itemPcs.toString()}'),
                                SizedBox(height: spacing),
                              ],
                            ),
                          ),
                          DataCell(Text(item.itemPurity)),
                          DataCell(Text(item.itemGrossWeight.toString())),
                          DataCell(Text(item.itemNetWeight.toString())),
                          DataCell(Text(item.ratePerGram.toString())),
                          DataCell(Text(item.otherCharges.toString())),
                          DataCell(Text(item.labourCharges.toString())),
                          DataCell(Text(item.gstCharges.toString())),
                          DataCell(Text("${item.itemPrice + item.otherCharges}")),
                          DataCell(Text("${item.grossAmount + item.otherCharges}")),
                        ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing),
              ElevatedButton(
                onPressed: () {
                  _generateAndSharePdf(context);
                },
                child: Text("GENERATE BILL"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generateAndSharePdf(BuildContext context) async {
    final invoiceNumber = generateInvoiceNumber(); // Generate a unique invoice number
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Invoice #$invoiceNumber", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Buyer Name: $buyerName"),
              pw.Text("Buyer Contact: $buyerContact"),
              pw.Text("Buyer Aadhar: $buyerAdhar"),
              pw.Text("Buyer Address: $buyerAddress"),
              pw.Text("Buyer PAN: $buyerPan"),
              pw.SizedBox(height: 20),
              pw.Text("GSTN No : 27CKXPS9939M1ZK"),
              pw.Text("GST Type : SGST + CGST"),
              pw.Text("Date & Time : \n${formatDateTime(DateTime.now())}"),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Particulars', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Purity', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Gross Wt.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Net Wt.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Rate [ Per Gm ]', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Other Charges', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Making', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('GST', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Total At.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(2),
                        child: pw.Text('Gross At.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (var item in billingItems)
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Item name : ${item.itemName}', style: pw.TextStyle(fontSize: 5)),
                              pw.SizedBox(height: 2),
                              pw.Image(
                                pw.MemoryImage(File(item.itemImage).readAsBytesSync()),
                                width: 100,
                                height: 50,
                                fit: pw.BoxFit.cover,
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text('Pcs : ${item.itemPcs}', style: pw.TextStyle(fontSize: 5)),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.itemPurity, style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.itemGrossWeight.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.itemNetWeight.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.ratePerGram.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.otherCharges.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.labourCharges.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(item.gstCharges.toString(), style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text("${item.itemPrice + item.otherCharges}", style: pw.TextStyle(fontSize: 5)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text("${item.grossAmount + item.otherCharges}", style: pw.TextStyle(fontSize: 5)),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save and share the PDF
    await requestPermissions();
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/invoice_$invoiceNumber.pdf");
    await file.writeAsBytes(await pdf.save());

    Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'invoice_$invoiceNumber.pdf',
    );
  }
}
