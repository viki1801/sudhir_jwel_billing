import 'package:flutter/material.dart';

class PaymentDetails extends StatefulWidget {
  final String itemName;
  final String itemPurity;
  final int pieces;
  final double grossWt;
  final double netWt;
  final double ratePerGram;
  final double otherCharges;
  final double itemPrice;
  final double subtractModPrice;
  final void Function(
      double newGrossAmount,
      double newLabourCharges,
      double newGstCharges,
      double newTotalAmount
      )? onValuesChanged;

  const PaymentDetails({
    Key? key,
    required this.itemPrice,
    required this.subtractModPrice,
    required this.itemName,
    required this.itemPurity,
    required this.pieces,
    required this.grossWt,
    required this.netWt,
    required this.ratePerGram,
    required this.otherCharges,
    this.onValuesChanged,
  }) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  int _labourPercentage = 0;
  late double _billAmount;
  late double _modAmount;
  late double totalAmount;

  final double cgst = 1.50;
  final double sgst = 1.50;

  @override
  void initState() {
    super.initState();
    _billAmount = widget.itemPrice;
    _modAmount = widget.subtractModPrice;
    // Schedule total amount update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateTotalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    _billAmount = widget.itemPrice;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Gross Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      //"₹ ${grossAmount.toStringAsFixed(2)}",
                      "₹ ${totalAmount}",
                      style: const TextStyle(
                        fontSize: 34.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.blueGrey,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                buildDetailRow("Item Price", _billAmount),
                buildDetailRow("Labour Charges", calculateTotalLabour(_billAmount, _labourPercentage)),
                buildLabourSlider(),
                buildDetailRow("Total GST", calculateGST(_billAmount)),
                buildDetailRow("Mod Price", _modAmount),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              const Icon(Icons.currency_rupee, size: 17.0),
              Text(
                value.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLabourSlider() {
    return Column(
      children: [
        Text(
          "$_labourPercentage%",
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          min: 0,
          max: 20,
          activeColor: Colors.black87,
          inactiveColor: Colors.grey,
          divisions: 20,
          value: _labourPercentage.toDouble(),
          onChanged: (double newValue) {
            setState(() {
              _labourPercentage = newValue.round();
              updateTotalAmount();
            });
          },
        ),
      ],
    );
  }

  void updateTotalAmount() {
    final labourCharges = calculateTotalLabour(_billAmount, _labourPercentage);
    final gstCharges = calculateGST(_billAmount);
    totalAmount = _billAmount + labourCharges + calculateGST(_billAmount) - _modAmount;

    // Call the onValuesChanged callback with the updated values
    widget.onValuesChanged?.call(
      _billAmount,
      labourCharges,
      gstCharges,
      totalAmount,
    );
  }

  double calculateGST(double billAmount) {
    double GSTpercentage = cgst + sgst;
    return (billAmount * GSTpercentage) / 100;
    //return GST;
  }

  double calculateTotalPayment(double billAmount, int labourPercentage) {
    double totalPayment =
        calculateTotalLabour(billAmount, labourPercentage) + billAmount;
    return totalPayment;
  }

  double calculateTotalLabour(double billAmount, int labourPercentage) {
    if (billAmount < 0 || billAmount.toString().isEmpty) {
      return 0.0; // Handle invalid bill amount
    }
    return (billAmount * labourPercentage) / 100;
  }
}
