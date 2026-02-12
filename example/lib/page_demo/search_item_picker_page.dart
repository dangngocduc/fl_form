import 'package:example/group_demo_widget.dart';
import 'package:fl_form/formfield/fl_search_item_form_field.dart';
import 'package:flutter/material.dart';

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
                  onSearch: (keyword) async {
                    return ['Afghanistan', 'Aland Islands', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla'];
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class SimpleData {
  final String title;
  final String subTitle;

  SimpleData({required this.title, required this.subTitle});
}
