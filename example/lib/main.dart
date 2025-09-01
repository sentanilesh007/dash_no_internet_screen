import 'package:dash_no_internet_screen/dash_no_internet_screen.dart';
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
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///wrap with DashNoInterNetScreen for your project any screen
    return DashNoInterNetScreen(
      image: "assets/no_wifi.png",
      text: "Oops! You're offline!",
      textStyle: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
      retryButtonText: "Reconnect",
      retryButtonColor: Colors.blue,
      retryButtonTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      retryButtonBorderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.grey.shade100,
      textAlign: TextAlign.center,
      spacing: 50,
      onInternetAvailable: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Internet connected!")),
        );
      },
      onRetryFailed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("no connection yet, please try again!")),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(child: Text("Your device is online!", style: TextStyle(fontSize: 16))),
      ),
    );
  }
}
