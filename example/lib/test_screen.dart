// import 'package:dash_no_internet_screen/dash_no_internet_screen.dart'; //import package
// import 'package:flutter/material.dart';
//
// /// this is how to use in your app page for example
// class TestScreen extends
// StatelessWidget {
//   const TestScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ///wrap with DashNoInterNetScreen for your project any screen
//     return DashNoInterNetScreen(
//       image: 'assets/no_internet.png', //add it your image
//       text: 'No internet? Please Check Your Internet Connection!', //add it your text
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Test Screen"), centerTitle: true),
//         body: const Center(child: Text("your device online!", style: TextStyle(fontSize: 16))),
//       ),
//     );
//   }
// }
import 'package:dash_no_internet_screen/dash_no_internet_screen.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashNoInterNetScreen(
      image: "assets/no_wifi.png",
      text: "Oops! You're offline 🚫",
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
