import 'package:flutter/material.dart';

class StepperTextField extends StatelessWidget {
  const StepperTextField({super.key, required this.controller, required this.labeltext, required this.keyboardType, required this.icon,});


  final IconData icon;
  final TextEditingController controller;
  final String labeltext;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            icon,
            color: Colors.black54
        ),
            const SizedBox(width: 5,),
            Expanded(
              child: TextField(
              style:const TextStyle(
              color: Colors.black,
              fontSize:18,
              ),
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
              labelText: labeltext,
              hintStyle: const TextStyle(
                  color: Colors.black54,
                  letterSpacing: 1),
              ),
              ),
            ),
        const SizedBox(height: 15)
      ],
    );
  }
}
