import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';
import 'package:sudhir_jwel_billing/Added%20Items/added_item_tile.dart';

import '../Custom Widgets/stepper_textfield.dart';

class AddItemPage extends StatefulWidget {
  final List<BillingItem> billingItems;

  const AddItemPage({Key? key, required this.billingItems}) : super(key: key);

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
      body: Column(
        children: [
          Expanded(
            child: AddedItem(
              billingItems: widget.billingItems,
              onDeleteItem: _deleteItem,
              onEditItem: _editItem,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle Create Invoice action
              },
              child: const Text("CREATE INVOICE"),
            ),
          ),
        ],
      ),
    );
  }
}
