import 'package:fl_form/formfield/fl_raw_bool_form_field.dart';
import 'package:fl_form/formfield/fl_switch_form_field.dart';
import 'package:flutter/material.dart';

class BoolFormFieldPage extends StatefulWidget {
  const BoolFormFieldPage({super.key});

  @override
  State<BoolFormFieldPage> createState() => _BoolFormFieldPageState();
}

class _BoolFormFieldPageState extends State<BoolFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            FlSwitchFormField(label: 'Select All'),
            const SizedBox(height: 24),
            FlRawBoolFormField(
              title: 'Select All',
              rawBuilder: (context, data, didChange) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: data ?? false,
                        onChanged: (value) {
                          didChange(value);
                        },
                      ),
                      const Expanded(child: Text('Select All')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
