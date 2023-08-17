import 'package:example/page_demo/avatar_name_widget.dart';
import 'package:fl_form/formfield/fl_checkbox_group_form_field.dart';
import 'package:flutter/material.dart';

class FlCheckBoxGroupFormFieldPage extends StatefulWidget {
  const FlCheckBoxGroupFormFieldPage({Key? key}) : super(key: key);

  @override
  State<FlCheckBoxGroupFormFieldPage> createState() =>
      _FlCheckBoxGroupFormFieldPageState();
}

class _FlCheckBoxGroupFormFieldPageState
    extends State<FlCheckBoxGroupFormFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            FlCheckboxGroupFormField(
              label: 'Select Item',
              itemBuilder: (context, value, child) {
                return Container(
                  child: Row(
                    children: [
                      AvatarNameWidget(
                        radius: 12,
                        name: value,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [Text(value)],
                        ),
                      )
                    ],
                  ),
                );
              },
              options: const [
                'Item 1',
                'Item 2',
                'Item 3',
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            FlCheckboxGroupFormField(
              isRequired: true,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Data invalid';
                return null;
              },
              itemBuilder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      AvatarNameWidget(
                        radius: 24,
                        name: value,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'dangngocduc.bk@gmail.com',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              label: 'Select Item',
              options: const [
                'Dang Ngoc Duc',
                'Vu Manh Quang',
                'Hoang Van Thai',
                'Nguyẽn Quang Sang',
                'Chu Ngoc Mai',
                'Do Thu Giang',
              ],
            )
          ],
        ),
      ),
    );
  }
}
