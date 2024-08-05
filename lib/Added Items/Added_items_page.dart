import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/Added%20Items/added_item_form.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';


class AddItemPage extends StatelessWidget {
  final List<BillingItem> billingItems;

  const AddItemPage({Key? key, required this.billingItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Added Items"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddedItem(billingItems: billingItems),
          ),
          ElevatedButton(onPressed: (){}, child: Text("CREATE INVOICE"))
        ],
      ),
    );
  }
}
