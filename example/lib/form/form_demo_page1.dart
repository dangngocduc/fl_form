import 'dart:math';

import 'package:fl_form/fl_form.dart';
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
  bool _obscureText = true;
  final TextEditingController _pwController = TextEditingController();

  Future? future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form SignIn'),
      ),
      body: FlFormBodyStateAsync(
        future: future,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlTextFormField(
                  label: 'Username',
                  placeholderText: 'Type username',
                  onSaved: (newValue) {},
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                FlPasswordFormField(
                  label: 'Password',
                  onSaved: (newValue) {},
                  obscureText: _obscureText,
                  textEditingController: _pwController,
                  validator: (value) {
                    return null;
                  },
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        _pwController.text = _suggestPassword();
                        _obscureText = false;
                        setState(() {});
                      },
                      child: const Text('Suggest password'),
                    ),
                  ],
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
                            fixedSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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
                            fixedSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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

  String _suggestPassword() {
    Random random = Random();
    String pw = "";
    for (int i = 0; i < 8; ++i) {
      String supply = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKMNOPQRSTUVWXYZ1234567890';
      int pos = random.nextInt(supply.length);
      pw += supply.substring(pos, pos + 1);
    }
    return pw;
  }
}
