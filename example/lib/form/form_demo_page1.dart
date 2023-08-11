import 'dart:developer' as developer;
import 'package:fl_form/formfield/fl_text_form_field.dart';
import 'package:fl_form/page/fl_button_state_async.dart';
import 'package:fl_form/page/fl_form_body_state_async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormDemoPage1 extends StatefulWidget {
  const FormDemoPage1({Key? key}) : super(key: key);

  @override
  State<FormDemoPage1> createState() => _FormDemoPage1State();
}

class _FormDemoPage1State extends State<FormDemoPage1> {
  Future? future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form SignIn'),
      ),
      body: FlFormBodyStateAsync(
        future: future,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlTextFormField(
                  label: 'Username',
                  placeholderText: 'Type username',
                  onSaved: (newValue) {},
                  validator: (value) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                FlTextFormField(
                  label: 'Password',
                  isPassword: true,
                  placeholderText: 'Type pass',
                  onSaved: (newValue) {},
                  validator: (value) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                FlButtonStateAsync(
                  future: future,
                  builder: (context, state) {
                    if (state == FlButtonState.enable) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          setState(() {
                            future = Future.delayed(
                              const Duration(seconds: 2),
                              () async {
                                return null;
                              },
                            );
                          });
                        },
                        child: const Text('Sign In'),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const CupertinoActivityIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
