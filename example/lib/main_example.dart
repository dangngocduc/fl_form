import 'package:example/page_demo/all_form_fields_page.dart';
import 'package:example/page_demo/avatar_form_field_page.dart';
import 'package:example/page_demo/bool_form_field_page.dart';
import 'package:example/page_demo/date_form_field_page.dart';
import 'package:example/page_demo/fl_checkbox_group_form_field_page.dart';
import 'package:example/page_demo/fl_money_form_field_page.dart';
import 'package:example/page_demo/fl_radio_button_form_field_page.dart';
import 'package:example/page_demo/search_item_picker_page.dart';
import 'package:example/page_demo/text_form_field_page.dart';
import 'package:flutter/material.dart';

import 'form/form_demo_page1.dart';
import 'page_demo/item_picker_page.dart';
import 'page_demo/multiple_item_picker_page.dart';

class MainExample extends StatelessWidget {
  final VoidCallback onToggleTheme;

    const MainExample({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        centerTitle: true,
        title: const Text('Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          ),
        ],
      ),
            body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return AllFormFieldsPage(onToggleTheme: onToggleTheme);
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('All Form Fields'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SearchItemPickerPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Search Demo'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const TextFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Text Input FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AvatarFormFieldPage();
                  },
                ));
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Avatar FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const DateFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Date FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ItemPickerPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Single Item Selector FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const MultipleItemPickerPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Multiple Item Selector FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const BoolFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Bool FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const FlRadioButtonFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Radio Group FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const FlCheckBoxGroupFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Checkbox Group FormField'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          //FormDemoPage1
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const FormDemoPage1();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Demo Form 1'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const FlMoneyFormFieldPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Demo Form Money'),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
