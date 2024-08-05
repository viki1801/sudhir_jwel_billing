import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/Stepper%20forms/buyer_form.dart';
import 'package:sudhir_jwel_billing/Stepper%20forms/item__form.dart';
import 'package:sudhir_jwel_billing/Stepper%20forms/payment_details.dart';
import 'package:sudhir_jwel_billing/Stepper%20forms/verify_payment_form.dart';
import 'package:sudhir_jwel_billing/model/billing_item.dart';
import 'Added Items/Added_items_page.dart';
import 'Stepper forms/mod_form.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key}) : super(key: key);

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  double itemPrice = 0.0;
  double subtractModPrice = 0.0;
  double grossAmount = 0.0;
  double labourCharges = 0.0;
  double gstCharges = 0.0;
  double cgst = 0.0;
  double sgst = 0.0;
  double totalAmount = 0.0;

  // Buyer Textfield Controllers
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final adharController = TextEditingController();
  final addController = TextEditingController();
  final panController = TextEditingController();

  // Item Textfield Controllers
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemGrossWeightController = TextEditingController();
  final itemNetWeightController = TextEditingController();
  final itemPcsController = TextEditingController();
  final itemImageController = TextEditingController();
  final itemPurityController = TextEditingController();
  final ratePerGramController = TextEditingController();
  final otherChargesController = TextEditingController();

  // Mod TextField Controller
  final modNameController = TextEditingController();
  final modWeightController = TextEditingController();
  final modPriceController = TextEditingController();

  // List to hold billing items
  final List<BillingItem> billingItems = [];
  int currentStep = 0;

  void addItem(BillingItem item) {
    setState(() {
      billingItems.add(item);
      labourCharges += item.labourCharges;
      gstCharges += item.gstCharges;
    });
  }

  void handleAddItem() {
    final newItem = BillingItem(
      itemName: itemNameController.text,
      itemPrice: double.tryParse(itemPriceController.text) ?? 0.0,
      itemGrossWeight: double.tryParse(itemGrossWeightController.text) ?? 0.0,
      itemNetWeight: double.tryParse(itemNetWeightController.text) ?? 0.0,
      itemPcs: int.tryParse(itemPcsController.text) ?? 0,
      itemImage: itemImageController.text,
      itemPurity: itemPurityController.text,
      ratePerGram: double.tryParse(ratePerGramController.text) ?? 0.0,
      otherCharges: double.tryParse(otherChargesController.text) ?? 0.0,
      labourCharges: labourCharges,
      gstCharges: gstCharges,
      grossAmount: totalAmount,
    );

    addItem(newItem);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemPage(
          billingItems: billingItems,
        ),
      ),
    );
  }

  void updatePaymentDetails({
    required double newGrossAmount,
    required double newLabourCharges,
    required double newGstCharges,
    required double newTotalAmount,
  }) {
    setState(() {
      grossAmount = newGrossAmount;
      labourCharges = newLabourCharges;
      gstCharges = newGstCharges;
      totalAmount = newTotalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Billing Section"),
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        connectorColor: const MaterialStatePropertyAll(Colors.black87),
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            handleAddItem();
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          }
        },
        onStepTapped: (step) => setState(() => currentStep = step),
      ),
    );
  }

  List<Step> getSteps() => [
    // Buyer
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text("Buyer"),
      content: BuyerForm(
        nameController: nameController,
        contactController: contactController,
        addController: addController,
        adharController: adharController,
        panController: panController,
      ),
    ),

    // Item Form
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: const Text("Item"),
      content: Column(
        children: [
          ItemForm(
            itemNameController: itemNameController,
            itemPurityController: itemPurityController,
            itemPcsController: itemPcsController,
            itemGrossWeightController: itemGrossWeightController,
            itemNetWeightController: itemNetWeightController,
            ratePerGramController: ratePerGramController,
            otherChargesController: otherChargesController,
            itemPriceController: itemPriceController,
            onItemPriceChanged: (price) {
              setState(() {
                itemPrice = price;
              });
            },
          ),
        ],
      ),
    ),

    // Mod
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: const Text("Mod"),
      content: ModForm(
        modNameController: modNameController,
        modWeightController: modWeightController,
        modPriceController: modPriceController,
        onModPriceChanged: (price) {
          setState(() {
            subtractModPrice = price;
          });
        },
      ),
    ),

    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      title: const Text("Payment"),
      content: PaymentDetails(
        itemPrice: itemPrice,
        subtractModPrice: subtractModPrice,
        itemName: itemNameController.text,
        itemPurity: itemPurityController.text,
        pieces: int.tryParse(itemPcsController.text) ?? 0,
        grossWt: double.tryParse(itemGrossWeightController.text) ?? 0.0,
        netWt: double.tryParse(itemNetWeightController.text) ?? 0.0,
        ratePerGram: double.tryParse(ratePerGramController.text) ?? 0.0,
        otherCharges: double.tryParse(otherChargesController.text) ?? 0.0,
        onValuesChanged: (
            newGrossAmount,
            newLabourCharges,
            newGstCharges,
            newTotalAmount ) {
          updatePaymentDetails(
            newGrossAmount: newGrossAmount,
            newLabourCharges: newLabourCharges,
            newGstCharges: newGstCharges,
            newTotalAmount: newTotalAmount,
          );
        },
      ),
    ),


    Step(
      state: currentStep > 4 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 4,
      title: const Text("Verify"),
      content: VerifyPayment(
        itemName: itemNameController.text,
        itemPurity: itemPurityController.text,
        pieces: int.tryParse(itemPcsController.text) ?? 0,
        grossWt: double.tryParse(itemGrossWeightController.text) ?? 0.0,
        netWt: double.tryParse(itemNetWeightController.text) ?? 0.0,
        ratePerGram: double.tryParse(ratePerGramController.text) ?? 0.0,
        otherCharges: double.tryParse(otherChargesController.text) ?? 0.0,
        itemPrice: itemPrice,
        subtractModPrice: subtractModPrice,
        labourCharges: labourCharges,
        gstCharges: gstCharges,
        totalAmount: totalAmount,
      ),
    ),
  ];
}
