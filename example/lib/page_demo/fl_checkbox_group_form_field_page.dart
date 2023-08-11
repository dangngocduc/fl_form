import 'package:fl_form/formfield/fl_checkbox_group_form_field.dart';
import 'package:flutter/material.dart';

class FlCheckBoxGroupFormFieldPage extends StatefulWidget {
  const FlCheckBoxGroupFormFieldPage({Key? key}) : super(key: key);

  @override
  State<FlCheckBoxGroupFormFieldPage> createState() =>
      _FlCheckBoxGroupFormFieldPageState();
}

class _FlCheckBoxGroupFormFieldPageState
    extends State<FlCheckBoxGroupFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            FlCheckboxGroupFormField(
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
            FlCheckboxGroupFormField(
              isRequired: true,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Data invalid';
                return null;
              },
              label: 'Select Item',
              options: const [
                'Item 1',
                'Item 2',
                'Item 3',
                'Item 4',
                'Item 5',
                'Item 6',
              ],
            )
          ],
        ),
      ),
    );
  }
}
