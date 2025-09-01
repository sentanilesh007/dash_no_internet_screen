import 'test_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dash no internet screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestScreen(),
    );
  }
}
