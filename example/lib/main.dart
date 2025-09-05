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
      image: Image.asset(
        "assets/no_wifi.png",
        width: 150,
        height: 150,
      ),
      text: "Oops! You're offline!",
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      textAlign: TextAlign.center,
      buttonTextColor: Colors.white,
      buttonColor: Colors.blue,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      buttonText: "Reconnect",
      buttonTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
      buttonBorderShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      buttonStyle: ElevatedButton.styleFrom(elevation: 4, backgroundColor: Colors.blue),
      textStyle:  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      onInternetAvailable: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Internet connected!")),
        );
      },
      onRetryFailed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("no internet!")),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(
            child: Text("Your device is online!", style: TextStyle(fontSize: 16))),
      ),
    );
  }
}
