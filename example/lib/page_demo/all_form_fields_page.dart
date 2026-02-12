import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/fl_double_form_field.dart';
import 'package:fl_form/formfield/fl_int_form_field.dart';
import 'package:flutter/material.dart';

class SimpleData {
  final String title;
  final String subTitle;

  SimpleData({required this.title, required this.subTitle});

  @override
  String toString() {
    return title;
  }
}

class AllFormFieldsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const AllFormFieldsPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Form Fields'),
        actions: [IconButton(icon: const Icon(Icons.brightness_6), onPressed: onToggleTheme)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlTextFormField(label: 'Email', placeholderText: 'Type your email'),
            const SizedBox(height: 24),
            FlPasswordFormField(label: 'Password', placeholderText: 'Enter your password'),
            const SizedBox(height: 24),
            FlMoneyFormField(label: 'Amount', currency: 'USD'),
            const SizedBox(height: 24),
            FlDateFormField(label: 'Date of Birth', placeholderText: 'dd/MM/yyyy'),
            const SizedBox(height: 24),
            FlSwitchFormField(label: 'Accept Terms & Conditions'),
            const SizedBox(height: 24),
            FlAvatarFormField(label: 'Profile Picture'),
            const SizedBox(height: 24),
            FlIntFormField(label: 'Integer', placeholderText: 'Enter an integer'),
            const SizedBox(height: 24),
            FlDoubleFormField(label: 'Double', placeholderText: 'Enter a double'),
            const SizedBox(height: 24),
            FlTimeFormField(label: 'Time', placeholderText: 'HH:MM'),
            const SizedBox(height: 24),
            FlDateAndTimeFormField(label: 'Date and Time', placeholderText: 'dd/MM/yyyy HH:mm'),
            const SizedBox(height: 24),
            FlDurationFormField(label: 'Duration', placeholderText: 'hh:mm'),
            const SizedBox(height: 24),
            FlRadioButtonFormField(
              label: 'Radio Buttons',
              options: [
                FormFieldOption(value: 'Option 1'),
                FormFieldOption(value: 'Option 2'),
                FormFieldOption(value: 'Option 3'),
              ],
            ),
            const SizedBox(height: 24),
            FlCheckboxGroupFormField(
              label: 'Checkbox Group',
              options: [
                FormFieldOption(value: 'Option 1'),
                FormFieldOption(value: 'Option 2'),
                FormFieldOption(value: 'Option 3'),
              ],
            ),
            const SizedBox(height: 24),
            FlSegmentedButtonFormField<String>(
              label: 'Segmented Button',
              options: const [
                FormFieldOption(value: 'one', label: 'One'),
                FormFieldOption(value: 'two', label: 'Two'),
                FormFieldOption(value: 'three', label: 'Three'),
              ],
            ),
            const SizedBox(height: 24),
            SingleItemPickerFormField(
              label: 'Single Item Picker',
              options: [
                FormFieldOption(value: 'Title 1'),
                FormFieldOption(value: 'Title 2'),
              ],
            ),
            const SizedBox(height: 24),
            MultipleItemPickerFormField(
              label: 'Multiple Item Picker',
              options: [
                FormFieldOption(value: 'Title 1'),
                FormFieldOption(value: 'Title 2'),
              ],
            ),
            const SizedBox(height: 24),
            FlSearchItemFormField(
              label: 'Search Item Picker',
              onSearch: (query) async {
                await Future.delayed(const Duration(seconds: 1));
                return ['Result 1', 'Result 2'];
              },
            ),
            const SizedBox(height: 24),
            FlMultipleSearchItemFormField(
              label: 'Multiple Search Item Picker',
              onSearch: (query) async {
                await Future.delayed(const Duration(seconds: 1));
                return ['Result 1', 'Result 2'];
              },
            ),
          ],
        ),
      ),
    );
  }
}
