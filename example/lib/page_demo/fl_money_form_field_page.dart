import 'package:fl_form/formfield/fl_money_form_field.dart';
import 'package:flutter/material.dart';

class FlMoneyFormFieldPage extends StatefulWidget {
  const FlMoneyFormFieldPage({Key? key}) : super(key: key);

  @override
  State<FlMoneyFormFieldPage> createState() => _FlMoneyFormFieldPageState();
}

class _FlMoneyFormFieldPageState extends State<FlMoneyFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            FlMoneyFormField(
              label: 'Money',
              currency: 'VND',
              placeholderText: 'Type your money',
            ),
            const SizedBox(
              height: 24,
            ),
            FlMoneyFormField(
              currency: 'USD',
              label: 'Money',
              placeholderText: 'Type your money',
            )
          ],
        ),
      ),
    );
  }
}
