import 'package:example/main_example.dart';
import 'package:fl_form/formfield/fl_form_field_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true).copyWith(extensions: [FlFormFieldTheme.light(context)]),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(extensions: [FlFormFieldTheme.dark(context)]),
      themeMode: _themeMode,
      home: MainExample(onToggleTheme: _toggleTheme),
    );
  }
}
