import 'package:flutter/material.dart';
import 'package:sudhir_jwel_billing/stepper_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      // MultiProvider(
      // providers: [
      //   ChangeNotifierProvider(create: (_) => BillingData()),
      // ],
      // child: const

      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: StepperPage(),
      );
    //);
  }
}
