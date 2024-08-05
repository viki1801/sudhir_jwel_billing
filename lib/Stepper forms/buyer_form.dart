import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/Custom%20Widgets/stepper_textfield.dart';



class BuyerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController addController;
  final TextEditingController adharController;
  final TextEditingController panController;

  const BuyerForm({
    Key? key,
    required this.nameController,
    required this.contactController,
    required this.addController,
    required this.adharController,
    required this.panController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Name
        StepperTextField(
          icon: Icons.person,
          controller: nameController,
          keyboardType: TextInputType.text,
          labeltext: 'Name',
        ),

        // Contact
        StepperTextField(
          icon: Icons.phone,
          controller: contactController,
          labeltext: 'Contact',
          keyboardType: TextInputType.number,
        ),

        // Address
        StepperTextField(
          icon: Icons.home,
          controller: addController,
          labeltext: "Address",
          keyboardType: TextInputType.text,
        ),

        // Adhar No.
        StepperTextField(
          icon: Icons.payment,
          controller: adharController,
          labeltext: "Adhar Number",
          keyboardType: TextInputType.text,
        ),

        // Pan No.
        StepperTextField(
          icon: Icons.add_card,
          controller: panController,
          labeltext: "Pan Number",
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
