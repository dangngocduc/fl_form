import 'package:fl_form/formfield/fl_text_form_field.dart';
import 'package:flutter/material.dart';

import '../group_demo_widget.dart';

class TextFormFieldPage extends StatelessWidget {
  const TextFormFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupDemoWidget(
              title: 'Simple',
              children: [
                FlTextFormField(
                  label: 'Name',
                  placeholderText: 'Type your name',
                ),
                FlTextFormField(
                  label: 'Password',
                  placeholderText: '* * * * * *',
                  isRequired: true,
                  isPassword: true,
                ),
                FlTextFormField(
                  label: 'Email',
                  isRequired: true,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Email invalid';
                  },
                  placeholderText: 'Type your email',
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            GroupDemoWidget(
              title: 'FormFiel Icon',
              children: [
                FlTextFormField(
                  prefixIcon: const Icon(Icons.person),
                  label: 'Name',
                  placeholderText: 'Type your name',
                ),
                FlTextFormField(
                  prefixIcon: const Icon(Icons.lock),
                  label: 'Password',
                  placeholderText: '* * * * * *',
                  isRequired: true,
                  isPassword: true,
                ),
                FlTextFormField(
                  prefixIcon: const Icon(Icons.email),
                  label: 'Email',
                  isRequired: true,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return 'Email invalid';
                  },
                  placeholderText: 'Type your email',
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            GroupDemoWidget(
              title: 'FormFiel Icon',
              children: [
                FlTextFormField(
                  maxLines: 4,
                  label: 'Description',
                  placeholderText: 'Type your description',
                ),
                FlTextFormField(
                  maxLines: 4,
                  label: 'Description',
                  autovalidateMode: AutovalidateMode.always,
                  placeholderText: 'Type your description',
                  validator: (value) {
                    return 'Description invalid';
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
