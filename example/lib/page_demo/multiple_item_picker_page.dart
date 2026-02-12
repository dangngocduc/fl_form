import 'package:example/group_demo_widget.dart';
import 'package:example/page_demo/fl_checkbox_group_form_field_page.dart';
import 'package:fl_form/formfield/form_field_option.dart';
import 'package:fl_form/formfield/multiple_item_picker_form_field.dart';
import 'package:flutter/material.dart';

import 'item_picker_page.dart';

class MultipleItemPickerPage extends StatefulWidget {
  const MultipleItemPickerPage({Key? key}) : super(key: key);

  @override
  State<MultipleItemPickerPage> createState() => _MultipleItemPickerPageState();
}

class _MultipleItemPickerPageState extends State<MultipleItemPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupDemoWidget(
              title: 'Multiple Item Picker',
              children: [
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items',
                  placeholderText: 'Select Items',
                  // contentSelectedBuilder: (data, context) => Wrap(
                  //   spacing: 8,
                  //   runSpacing: 0,
                  //   children: [
                  //     ...data?.map((e) => Chip(label: Text(e.toString()), backgroundColor: Theme.of(context).cardColor, shape: const StadiumBorder())) ?? [],
                  //   ],
                  // ),
                  options: [
                    FormFieldOption(value: 'Afghanistan'),
                    FormFieldOption(value: 'Aland Islands'),
                    FormFieldOption(value: 'Albania'),
                    FormFieldOption(value: 'Algeria'),
                    FormFieldOption(value: 'American Samoa'),
                    FormFieldOption(value: 'Andorra'),
                    FormFieldOption(value: 'Angola'),
                    FormFieldOption(value: 'Anguilla'),
                  ],
                ),
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
                  builder: AvatarNameFormFieldWidgetBuilder(small: true),
                  // itemListBuilder: (context, value, isSelected) {
                  //   return Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  //     child: Row(
                  //       children: [
                  //         const CircleAvatar(radius: 24),
                  //         const SizedBox(width: 12),
                  //         Expanded(child: Text(value.toString())),
                  //         if (isSelected) const Icon(Icons.done),
                  //       ],
                  //     ),
                  //   );
                  // },
                  // contentSelectedBuilder: (data, context) => Wrap(
                  //   spacing: 8,
                  //   runSpacing: 0,
                  //   children: [
                  //     ...data?.map(
                  //           (e) => Chip(
                  //             avatar: RandomAvatar(e.toString(), width: 32, height: 32),
                  //             label: Text(e.toString()),
                  //             backgroundColor: Theme.of(context).cardColor,
                  //             shape: const StadiumBorder(),
                  //           ),
                  //         ) ??
                  //         [],
                  //   ],
                  // ),
                  options: [
                    FormFieldOption(value: 'Afghanistan'),
                    FormFieldOption(value: 'Aland Islands'),
                    FormFieldOption(value: 'Albania'),
                    FormFieldOption(value: 'Algeria'),
                    FormFieldOption(value: 'American Samoa'),
                    FormFieldOption(value: 'Andorra'),
                    FormFieldOption(value: 'Angola'),
                    FormFieldOption(value: 'Anguilla'),
                  ],
                ),
                MultipleItemPickerFormField(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
                  // contentSelectedBuilder: (data, context) => Wrap(
                  //   spacing: 8,
                  //   runSpacing: 0,
                  //   children: [
                  //     ...data?.map(
                  //           (e) => Chip(
                  //             avatar: RandomAvatar(e.title, width: 32, height: 32),
                  //             label: Text(e.title),
                  //             backgroundColor: Theme.of(context).cardColor,
                  //             shape: const StadiumBorder(),
                  //           ),
                  //         ) ??
                  //         [],
                  //   ],
                  // ),
                  options: [
                    SimpleData(title: 'Title 1', subTitle: 'Sub title 1'),
                    SimpleData(title: 'Title 2', subTitle: 'Sub title 2'),
                    SimpleData(title: 'Title 3', subTitle: 'Sub title 3'),
                    SimpleData(title: 'Title 4', subTitle: 'Sub title 4'),
                    SimpleData(title: 'Title 5', subTitle: 'Sub title 5'),
                    SimpleData(title: 'Title 6', subTitle: 'Sub title 6'),
                    SimpleData(title: 'Title 7', subTitle: 'Sub title 7'),
                    SimpleData(title: 'Title 8', subTitle: 'Sub title 8'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            GroupDemoWidget(
              title: 'Multiple Item Picker Validate',
              children: [
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items',
                  placeholderText: 'Select Items',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Data Invalid';
                  },
                  options: [
                    FormFieldOption(value: 'Afghanistan'),
                    FormFieldOption(value: 'Aland Islands'),
                    FormFieldOption(value: 'Albania'),
                    FormFieldOption(value: 'Algeria'),
                    FormFieldOption(value: 'American Samoa'),
                    FormFieldOption(value: 'Andorra'),
                    FormFieldOption(value: 'Angola'),
                    FormFieldOption(value: 'Anguilla'),
                  ],
                ),
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Data Invalid';
                  },
                  // itemListBuilder: (context, value, isSelected) {
                  //   return Container(
                  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  //     child: Row(
                  //       children: [
                  //         const CircleAvatar(radius: 24),
                  //         const SizedBox(width: 12),
                  //         Expanded(child: Text(value.toString())),
                  //         if (isSelected) const Icon(Icons.done),
                  //       ],
                  //     ),
                  //   );
                  // },
                  // contentSelectedBuilder: (data, context) => Row(
                  //   children: [
                  //     const CircleAvatar(radius: 16),
                  //     const SizedBox(width: 12),
                  //     Expanded(child: Text(data.toString())),
                  //   ],
                  // ),
                  options: [
                    FormFieldOption(value: 'Afghanistan'),
                    FormFieldOption(value: 'Aland Islands'),
                    FormFieldOption(value: 'Albania'),
                    FormFieldOption(value: 'Algeria'),
                    FormFieldOption(value: 'American Samoa'),
                    FormFieldOption(value: 'Andorra'),
                    FormFieldOption(value: 'Angola'),
                    FormFieldOption(value: 'Anguilla'),
                  ],
                ),
                MultipleItemPickerFormField(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Data Invalid';
                  },
                  //contentSelectedBuilder: (data, context) => Wrap(spacing: 8, children: [...data?.map((e) => Chip(label: Text(e.title))).toList() ?? []]),
                  options: [
                    SimpleData(title: 'Title 1', subTitle: 'Sub title 1'),
                    SimpleData(title: 'Title 2', subTitle: 'Sub title 2'),
                    SimpleData(title: 'Title 3', subTitle: 'Sub title 3'),
                    SimpleData(title: 'Title 4', subTitle: 'Sub title 4'),
                    SimpleData(title: 'Title 5', subTitle: 'Sub title 5'),
                    SimpleData(title: 'Title 6', subTitle: 'Sub title 6'),
                    SimpleData(title: 'Title 7', subTitle: 'Sub title 7'),
                    SimpleData(title: 'Title 8', subTitle: 'Sub title 8'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
