import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';
import 'package:sudhir_jwel_billing/Added%20Items/added_item_tile.dart';

import '../Custom Widgets/stepper_textfield.dart';
import '../Invoice/invoice_paage.dart';

class AddItemPage extends StatefulWidget {
  final List<BillingItem> billingItems;
  final String buyerName;
  final String buyerContact;
  final String buyerAdhar;
  final String buyerAddress;
  final String buyerPan;


  const AddItemPage({
    super.key,
    required this.billingItems,
    required this.buyerName,
    required this.buyerContact,
    required this.buyerAdhar,
    required this.buyerAddress,
    required this.buyerPan
  });

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {

  late List<BillingItem> _billingItems;

  @override
  void initState() {
    super.initState();
    _billingItems = widget.billingItems;
  }

  void _deleteItem(int index) {
    setState(() {
      _billingItems.removeAt(index);
    });
  }

  void _editItem(int index) { }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Added Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display buyer details and billing items
            Text("Buyer Name : ${widget.buyerName}"),
            Text("Buyer Contact : ${widget.buyerContact}"),
            Text("Buyer Aadhar : ${widget.buyerAdhar}"),
            Text("Buyer Address : ${widget.buyerAddress}"),
            Text("Buyer PAN : ${widget.buyerPan}"),
            Divider(thickness: 1.0,),
            Expanded(
              child: AddedItemTile(
                billingItems: widget.billingItems,
                onDeleteItem: _deleteItem,
                onEditItem: _editItem,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoicePage(
                        billingItems: _billingItems,
                        buyerName: widget.buyerName,
                        buyerContact: widget.buyerContact,
                        buyerAdhar: widget.buyerAdhar,
                        buyerAddress: widget.buyerAddress,
                        buyerPan: widget.buyerPan,
                      ),
                    ),
                  );
                },
                child: const Text("CREATE INVOICE"),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
