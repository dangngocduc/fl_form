import 'dart:developer' as developer;
import 'package:fl_form/formfield/fl_date_and_time_form_field.dart';
import 'package:fl_form/formfield/fl_date_form_field.dart';
import 'package:fl_form/formfield/fl_duration_form_field.dart';
import 'package:fl_form/formfield/fl_time_form_field.dart';
import 'package:flutter/material.dart';

import '../group_demo_widget.dart';

class DateFormFieldPage extends StatelessWidget {
  const DateFormFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupDemoWidget(
              title: 'Date Form Field',
              children: [
                FlDateFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                ),
                FlDateFormField(
                  prefixIcon: const Icon(Icons.date_range),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                ),
                FlDateFormField(
                  autovalidateMode: AutovalidateMode.always,
                  prefixIcon: const Icon(Icons.date_range),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                  validator: (value) {
                    return 'Date invalid';
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            GroupDemoWidget(
              title: 'Time Form Field',
              children: [
                FlTimeFormField(
                  label: 'Time Start',
                  placeholderText: 'HH:MM',
                ),
                FlTimeFormField(
                  label: 'Time Start',
                  placeholderText: 'HH:MM',
                  prefixIcon: Icon(Icons.alarm),
                ),
                FlTimeFormField(
                  label: 'Time Start',
                  placeholderText: 'HH:MM',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Time invalid';
                  },
                  prefixIcon: Icon(Icons.alarm),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            GroupDemoWidget(
              title: 'Date and Time Form Field',
              children: [
                FlDateAndTimeFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  prefixIcon: Icon(Icons.date_range),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                ),
                FlDateAndTimeFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                ),
                FlDateAndTimeFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 100)),
                  label: 'Date of birth',
                  placeholderText: 'dd/MM/yyyy',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) => 'Date invalid',
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            GroupDemoWidget(
              title: 'Duration',
              children: [
                FlDurationFormField(
                  prefixIcon: Icon(Icons.date_range),
                  label: 'Select Duration',
                  placeholderText: 'hh : mm',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
