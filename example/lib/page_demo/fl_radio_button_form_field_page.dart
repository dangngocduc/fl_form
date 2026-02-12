import 'package:fl_form/fl_form.dart';
import 'package:flutter/material.dart';

class FlRadioButtonFormFieldPage extends StatefulWidget {
  const FlRadioButtonFormFieldPage({Key? key}) : super(key: key);

  @override
  State<FlRadioButtonFormFieldPage> createState() => _FlRadioButtonFormFieldPageState();
}

class _FlRadioButtonFormFieldPageState extends State<FlRadioButtonFormFieldPage> {
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
              options: [
                FormFieldOption(value: 'Item 1'),
                FormFieldOption(value: 'Item 2'),
                FormFieldOption(value: 'Item 3'),
              ],
            ),
            const SizedBox(height: 24),
            FlRadioButtonFormField(
              isRequired: true,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value == null) return 'Data invalid';
                return null;
              },
              label: 'Select Item',
              options: [
                FormFieldOption(value: 'Option 1', label: 'Option 1'),
                FormFieldOption(value: 'Option 2', label: 'Option 2'),
                FormFieldOption(value: 'Option 3', label: 'Option 3'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
