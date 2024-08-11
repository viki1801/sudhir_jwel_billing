// // import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:pdf_image_renderer/pdf_image_renderer.dart';
// //
//
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// String generateInvoiceNumber() {
//   final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//   final random = Random();
//   final randomSuffix = random.nextInt(1000).toString().padLeft(3, '0');
//   return '${timestamp.substring(timestamp.length - 6)}-$randomSuffix';
// }
//
// Future<void> requestPermissions() async {
//   final status = await [
//     Permission.storage,
//     Permission.manageExternalStorage, // For Android 11 and later
//   ].request();
//
//   if (status[Permission.storage]!.isGranted &&
//       status[Permission.manageExternalStorage]!.isGranted) {
//     print('Permissions granted');
//   } else {
//     print('Permissions denied');
//   }
// }
// Future<void> _generateAndSharePdf(BuildContext context) async {
//   final invoiceNumber = generateInvoiceNumber(); // Generate a unique invoice number
//   final pdf = pw.Document();
//
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("Invoice #$invoiceNumber", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 20),
//             pw.Text("Buyer Name: $buyerName"),
//             pw.Text("Buyer Contact: $buyerContact"),
//             pw.Text("Buyer Aadhar: $buyerAdhar"),
//             pw.Text("Buyer Address: $buyerAddress"),
//             pw.Text("Buyer PAN: $buyerPan"),
//             pw.SizedBox(height: 20),
//             pw.Table(
//               border: pw.TableBorder.all(),
//               children: [
//                 pw.TableRow(
//                   children: [
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Particulars', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Purity', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Gross Wt.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Net Wt.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Rate [ Per Gm ]', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Other Charges', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Making', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('GST', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Total At.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                     pw.Padding(
//                       padding: pw.EdgeInsets.all(2),
//                       child: pw.Text('Gross At.', style: pw.TextStyle(fontSize: 5,fontWeight: pw.FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//                 for (var item in billingItems)
//                   pw.TableRow(
//                     children: [
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Text('Item name: ${item.itemName}'),
//                             pw.Text('Pcs: ${item.itemPcs}'),
//                             if (item.itemImage.isNotEmpty)
//                               pw.Container(
//                                 width: 200, // Adjust width as needed
//                                 height: 70, // Adjust height as needed
//                                 child: pw.Image(
//                                   pw.MemoryImage(
//                                     File(item.itemImage).readAsBytesSync(),
//                                   ),
//                                   fit: pw.BoxFit.cover, // Adjust fit as needed
//                                 ),
//                               )],
//                         ),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.itemPurity),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.itemGrossWeight.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.itemNetWeight.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.ratePerGram.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.otherCharges.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.labourCharges.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text(item.gstCharges.toString()),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text("${item.itemPrice + item.otherCharges}"),
//                       ),
//                       pw.Padding(
//                         padding: pw.EdgeInsets.all(8),
//                         child: pw.Text("${item.grossAmount + item.otherCharges}"),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             pw.SizedBox(height: 20),
//           ],
//         );
//       },
//     ),
//   );
//
//   final directory = await getExternalStorageDirectory();
//   final path = '${directory!.path}/Invoice_$invoiceNumber.pdf';
//
//   final file = File(path);
//   await file.writeAsBytes(await pdf.save());
//
//   await Printing.sharePdf(bytes: await pdf.save(), filename: 'Invoice_$invoiceNumber.pdf');
// }
// }
