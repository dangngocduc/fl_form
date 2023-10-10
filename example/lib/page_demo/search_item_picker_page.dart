import 'package:example/group_demo_widget.dart';
import 'package:fl_form/formfield/fl_search_item_form_field.dart';
import 'package:fl_form/formfield/single_item_picker_form_field.dart';
import 'package:flutter/material.dart';

import 'avatar_name_widget.dart';

class SearchItemPickerPage extends StatefulWidget {
  const SearchItemPickerPage({Key? key}) : super(key: key);

  @override
  State<SearchItemPickerPage> createState() => _SearchItemPickerPageState();
}

class _SearchItemPickerPageState extends State<SearchItemPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupDemoWidget(
              title: 'Single Item Picker',
              children: [
                FlSearchItemFormField<String>(
                  label: 'Select Item',
                  placeholderText: 'Select Item',
                  contentSelectedBuilder: (data, context) => Text(
                    data.toString(),
                  ),
                  itemBuilder: (context, value, child) {
                    return ListTile(
                      title: Text(value),
                    );
                  },
                  onSearch: (keyword) async {
                    return [
                      'Afghanistan',
                      'Aland Islands',
                      'Albania',
                      'Algeria',
                      'American Samoa',
                      'Andorra',
                      'Angola',
                      'Anguilla',
                    ];
                  },
                  options: const [
                    'Afghanistan',
                    'Aland Islands',
                    'Albania',
                    'Algeria',
                    'American Samoa',
                    'Andorra',
                    'Angola',
                    'Anguilla',
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleData {
  final String title;
  final String subTitle;

  SimpleData({
    required this.title,
    required this.subTitle,
  });
}
