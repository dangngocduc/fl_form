import 'package:example/group_demo_widget.dart';
import 'package:fl_form/formfield/single_item_picker_form_field.dart';
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
                  contentSelectedBuilder: (data, context) => Text(
                    data.toString(),
                  ),
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
                SingleItemPickerFormField<Object>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  itemListBuilder: (context, value, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              value.toString(),
                            ),
                          ),
                          if (isSelected) const Icon(Icons.done)
                        ],
                      ),
                    );
                  },
                  contentSelectedBuilder: (data, context) => Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Text(
                        data.toString(),
                      ))
                    ],
                  ),
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
                SingleItemPickerFormField<SimpleData>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  itemListBuilder: (context, data, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                data.subTitle,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          )),
                          if (isSelected) const Icon(Icons.done)
                        ],
                      ),
                    );
                  },
                  contentSelectedBuilder: (data, context) => Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            data.subTitle,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ))
                    ],
                  ),
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
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
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
                  contentSelectedBuilder: (data, context) => Text(
                    data.toString(),
                  ),
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
                SingleItemPickerFormField<Object>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Data Invalid';
                  },
                  itemListBuilder: (context, value, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              value.toString(),
                            ),
                          ),
                          if (isSelected) const Icon(Icons.done)
                        ],
                      ),
                    );
                  },
                  contentSelectedBuilder: (data, context) => Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Text(
                        data.toString(),
                      ))
                    ],
                  ),
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
                SingleItemPickerFormField<SimpleData>(
                  label: 'Select Item customize',
                  placeholderText: 'Select Item',
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Data Invalid';
                  },
                  itemListBuilder: (context, data, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                data.subTitle,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          )),
                          if (isSelected) const Icon(Icons.done)
                        ],
                      ),
                    );
                  },
                  contentSelectedBuilder: (data, context) => Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            data.subTitle,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ))
                    ],
                  ),
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
                )
              ],
            )
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
