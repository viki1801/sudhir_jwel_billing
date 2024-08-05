import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/Custom%20Widgets/stepper_textfield.dart';


class ModForm extends StatefulWidget {
  final TextEditingController modNameController;
  final TextEditingController modWeightController;
  final TextEditingController modPriceController;
  final Function(double) onModPriceChanged;

  const ModForm({
    Key? key,
    required this.modNameController,
    required this.modWeightController,
    required this.modPriceController,
    required this.onModPriceChanged,
  }) : super(key: key);

  @override
  State<ModForm> createState() => _ModFormState();
}

class _ModFormState extends State<ModForm> {
  bool subtractFromTotal = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Mod Name
        StepperTextField(
          icon: Icons.gavel,
          controller: widget.modNameController,
          keyboardType: TextInputType.text,
          labeltext: 'Mod name',
        ),

        // Mod Weight
        StepperTextField(
          icon: Icons.balance,
          controller: widget.modWeightController,
          labeltext: 'Mod weight',
          keyboardType: TextInputType.number,
        ),

        // Mod Price
        StepperTextField(
          icon: Icons.currency_rupee,
          controller: widget.modPriceController,
          labeltext: "Mod price",
          keyboardType: TextInputType.text,
        ),

        CheckboxListTile(
          title: const Text('Subtract Mod Price from Total Amount'),
          value: subtractFromTotal, // Change this to subtractFromTotal
          onChanged: (value) {
            setState(() {
              subtractFromTotal = value!; // Change this to subtractFromTotal
              if (subtractFromTotal) { // Change this to subtractFromTotal
                double modPrice = double.tryParse(widget.modPriceController.text) ?? 0.0; // Change this to widget.modPriceController
                widget.onModPriceChanged(modPrice);
              } else {
                widget.onModPriceChanged(0.0);
              }
            });
          },
        ),

      ],
    );
  }
}
