import 'package:flutter/material.dart';
import 'package:mobile_updates_demo/screen/mobile_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile updates demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MobileForm(),
    );
  }
}
