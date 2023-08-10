import 'dart:ui';

import 'package:example/main_example.dart';
import 'package:fl_form/formfield/fl_avatar_form_field.dart';
import 'package:fl_form/formfield/date_range_form_field.dart';
import 'package:fl_form/formfield/drop_down_form_field.dart';
import 'package:fl_form/formfield/fl_form_field_theme.dart';
import 'package:fl_form/formfield/form_field_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' as matrix;
import 'dart:math' as math;

import 'page_demo/avatar_form_field_page.dart';
import 'custom_paint.dart';
import 'page_demo/date_form_field_page.dart';
import 'page_demo/text_form_field_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
      ),
    );
  }
}
