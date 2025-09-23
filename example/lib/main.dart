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
        "assets/ic_no_internet.png",
        fit: BoxFit.contain,
      ),
      titleText: "Oops !",
      titleTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      subtitleText: "No Internet Connection Found. Check your connection and start again.",
      subtitleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      textAlign: TextAlign.center,
      spacing: 15,
      buttonTextColor: Colors.white,
      buttonColor: Colors.blue,
      buttonPadding:
          const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      buttonText: "Try Again",
      buttonTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
      buttonBorderShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      buttonHeight: 50,
      buttonWidth: 250,
      buttonStyle:
          ElevatedButton.styleFrom(elevation: 4, backgroundColor: Colors.blue),
      onInternetAvailable: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Internet connected!")),
        );
      },
      onRetryFailed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("no internet found! please connect to internet and try again.")),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
        body: const Center(
            child: Text("Your device is online!", style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
