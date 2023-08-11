import 'package:example/main_example.dart';
import 'package:flutter/material.dart';

import 'package:fl_form/formfield/fl_form_field_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height,
            ),
          ),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData.dark(
                  useMaterial3: true,
                ).copyWith(extensions: [
                  FlFormFieldTheme.dark(context),
                ]),
                home: const MainExample(),
              );
            },
          )),
    );
  }
}
