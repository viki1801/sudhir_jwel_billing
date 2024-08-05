import 'package:flutter/material.dart';

class VerifyPayment extends StatelessWidget {
  final String itemName;
  final String itemPurity;
  final int pieces;
  final double grossWt;
  final double netWt;
  final double ratePerGram;
  final double otherCharges;
  final double itemPrice;
  final double subtractModPrice;
  final double labourCharges;
  final double gstCharges;
  final double totalAmount;

  const VerifyPayment({
    super.key,
    required this.itemName,
    required this.itemPurity,
    required this.pieces,
    required this.grossWt,
    required this.netWt,
    required this.ratePerGram,
    required this.otherCharges,
    required this.itemPrice,
    required this.subtractModPrice,
    required this.labourCharges,
    required this.gstCharges,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item Name: $itemName"),
          Text("Purity: $itemPurity"),
          Text("Pieces: $pieces"),
          Text("Gross Weight: $grossWt"),
          Text("Net Weight: $netWt"),
          Text("Rate Per Gram: $ratePerGram"),
          Text("Other Charges: $otherCharges"),
          Text("Item Price: $itemPrice"),
          Text("Subtract Mod Price: $subtractModPrice"),
          Text("Labour Charges: ${labourCharges.toStringAsFixed(2)}"),
          Text("GST charges: ${gstCharges.toStringAsFixed(2)}"),

          Text("Total Amount: ${totalAmount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
