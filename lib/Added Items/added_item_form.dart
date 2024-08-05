import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';

class AddedItem extends StatelessWidget {
  final List<BillingItem> billingItems;

  const AddedItem({super.key, required this.billingItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,  // This ensures that the ListView does not take infinite height
      itemCount: billingItems.length,
      itemBuilder: (context, index) {
        final item = billingItems[index];
        return ListTile(
          leading: item.itemImage.isNotEmpty
              ? Image.network(item.itemImage, width: 50, height: 50, fit: BoxFit.cover)
              : const Icon(Icons.image_not_supported),
          title: Text(item.itemName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: \$${item.itemPrice.toStringAsFixed(2)}'),
              Text('Gross Weight: ${item.itemGrossWeight} g'),
              Text('Net Weight: ${item.itemNetWeight} g'),
              Text('Purity: ${item.itemPurity}'),
              Text('Rate Per Gram: \$${item.ratePerGram.toStringAsFixed(2)}'),
              Text('Other Charges: \$${item.otherCharges.toStringAsFixed(2)}'),

              //TODO we have to add here labour charges
              Text('Labour Charges: \$${item.labourCharges.toStringAsFixed(2)}'),
              Text('Gst Charges: \$${item.gstCharges.toStringAsFixed(2)}'),

              Text('Gross Amount: \$${item.grossAmount.toStringAsFixed(2)}'),
            ],
          ),
          trailing: Text('Pcs: ${item.itemPcs}'),
        );
      },
    );
  }
}
