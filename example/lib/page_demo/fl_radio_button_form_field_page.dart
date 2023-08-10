import 'dart:developer' as developer;
import 'package:fl_form/formfield/fl_radio_button_form_field.dart';
import 'package:flutter/material.dart';

class FlRadioButtonFormFieldPage extends StatefulWidget {
  const FlRadioButtonFormFieldPage({Key? key}) : super(key: key);

  @override
  State<FlRadioButtonFormFieldPage> createState() =>
      _FlRadioButtonFormFieldPageState();
}

class _FlRadioButtonFormFieldPageState
    extends State<FlRadioButtonFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            FlRadioButtonFormField(
              label: 'Select Item',
              options: const [
                'Item 1',
                'Item 2',
                'Item 3',
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            FlRadioButtonFormField(
              isRequired: true,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value == null) return 'Data invalid';
              },
              label: 'Select Item',
              options: const [
                'Item 1',
                'Item 2',
                'Item 3',
              ],
            )
          ],
        ),
      ),
    );
  }
}
