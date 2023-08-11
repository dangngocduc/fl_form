import 'package:example/group_demo_widget.dart';
import 'package:fl_form/formfield/multiple_item_picker_form_field.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

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
                  contentSelectedBuilder: (data, context) => Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      ...data?.map((e) => Chip(
                                label: Text(e.toString()),
                                backgroundColor: Theme.of(context).cardColor,
                                shape: const StadiumBorder(),
                              )) ??
                          []
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
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
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
                  contentSelectedBuilder: (data, context) => Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      ...data?.map((e) => Chip(
                                avatar: RandomAvatar(
                                  e.toString(),
                                  width: 32,
                                  height: 32,
                                ),
                                label: Text(e.toString()),
                                backgroundColor: Theme.of(context).cardColor,
                                shape: const StadiumBorder(),
                              )) ??
                          []
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
                MultipleItemPickerFormField<SimpleData>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
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
                  contentSelectedBuilder: (data, context) => Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: [
                      ...data?.map((e) => Chip(
                                avatar: RandomAvatar(
                                  e.title,
                                  width: 32,
                                  height: 32,
                                ),
                                label: Text(e.title),
                                backgroundColor: Theme.of(context).cardColor,
                                shape: const StadiumBorder(),
                              )) ??
                          []
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
              title: 'Multiple Item Picker Validate',
              children: [
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items',
                  placeholderText: 'Select Items',
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
                MultipleItemPickerFormField<Object>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
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
                MultipleItemPickerFormField<SimpleData>(
                  label: 'Select Items customize',
                  placeholderText: 'Select Items',
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
                  contentSelectedBuilder: (data, context) => Wrap(
                    spacing: 8,
                    children: [
                      ...data
                              ?.map((e) => Chip(
                                    label: Text(e.title),
                                  ))
                              .toList() ??
                          []
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
