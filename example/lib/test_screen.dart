import 'package:dash_no_internet_screen/dash_no_internet_screen.dart'; //import package
import 'package:flutter/material.dart';

/// this is how to use in your app page for example
class TestScreen extends
StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///wrap with DashNoInterNetScreen for your project any screen
    return DashNoInterNetScreen(
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(child: Text("your device online!", style: TextStyle(fontSize: 16))),
      ),
    );
  }
}
