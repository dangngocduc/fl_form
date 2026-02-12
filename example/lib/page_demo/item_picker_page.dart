import 'package:example/group_demo_widget.dart';
import 'package:fl_form/fl_form.dart';
import 'package:flutter/material.dart';

class ItemPickerPage extends StatefulWidget {
  const ItemPickerPage({Key? key}) : super(key: key);

  @override
  State<ItemPickerPage> createState() => _ItemPickerPageState();
}

class _ItemPickerPageState extends State<ItemPickerPage> {
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
                SingleItemPickerFormField<Object>(
                  label: 'Select Item',
                  placeholderText: 'Select Item',
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
                SingleItemPickerFormField<Object>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
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
                SingleItemPickerFormField(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  builder: SimpleFormFieldWidgetBuilder(),
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
              title: 'Single Item Picker Validate',
              children: [
                SingleItemPickerFormField<Object>(
                  label: 'Select Item',
                  placeholderText: 'Select Item',
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
                SingleItemPickerFormField<Object>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
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
                SingleItemPickerFormField(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  autovalidateMode: AutovalidateMode.always,
                  builder: SimpleFormFieldWidgetBuilder(),
                  validator: (value) {
                    return 'Data Invalid';
                  },
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

//////////////////////////////////////////////////////////////////////////////

class SimpleData extends FormFieldOption {
  final String subTitle;

  SimpleData({required String title, required this.subTitle}) : super(value: title, label: title);
}

//////////////////////////////////////////////////////////////////////////////

class SimpleFormFieldWidgetBuilder implements FormFieldWidgetBuilder {
  @override
  Widget buildForContent(BuildContext context, FormFieldOption formFieldOption) {
    SimpleData simpleData = formFieldOption as SimpleData;
    return Row(
      children: [
        const CircleAvatar(radius: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(simpleData.label!, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(simpleData.subTitle, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget buildForList(BuildContext context, FormFieldOption formFieldOption, bool isSelected) {
    SimpleData simpleData = formFieldOption as SimpleData;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(radius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(simpleData.label!, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 2),
                Text(simpleData.subTitle, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          if (isSelected) const Icon(Icons.done),
        ],
      ),
    );
  }
}
