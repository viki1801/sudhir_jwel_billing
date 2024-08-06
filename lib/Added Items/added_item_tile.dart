import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';

class AddedItem extends StatelessWidget {
  final List<BillingItem> billingItems;
  final void Function(int) onDeleteItem;
  final void Function(int) onEditItem;

  const AddedItem({
    Key? key,
    required this.billingItems,
    required this.onDeleteItem,
    required this.onEditItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: billingItems.length,
      itemBuilder: (context, index) {
        final item = billingItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 8.0, // Adding elevation for 3D effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.itemImage.isNotEmpty
                  ? ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.file(
                  File(item.itemImage),
                  width: screenWidth - 16.0, // Responsive width
                  height: screenWidth * 0.5, // Responsive height
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                width: screenWidth - 16.0,
                // Responsive width
                height: screenWidth * 0.4,
                // Responsive height
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12.0)),
                  color: Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: \$${item.itemPrice.toStringAsFixed(2)}'),
                    Text('Gross Weight: ${item.itemGrossWeight} g'),
                    Text('Net Weight: ${item.itemNetWeight} g'),
                    Text('Purity: ${item.itemPurity}'),
                    Text('Rate Per Gram: \$${item.ratePerGram.toStringAsFixed(
                        2)}'),
                    Text('Other Charges: \$${item.otherCharges.toStringAsFixed(
                        2)}'),
                    Text(
                        'Labour Charges: \$${item.labourCharges.toStringAsFixed(
                            2)}'),
                    Text(
                        'Gst Charges: \$${item.gstCharges.toStringAsFixed(2)}'),
                    Text('Gross Amount: \$${item.grossAmount.toStringAsFixed(
                        2)}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pcs: ${item.itemPcs}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              onEditItem(index); // Call the edit function
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              onDeleteItem(index); // Call the delete function
                            },
                          ),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        );
      },
    );
  }

}