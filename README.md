# 🚀  Dash No Internet Screen 

[![Pub Version](https://img.shields.io/pub/v/yourpackage-name.svg)](link)  [![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)  [![GitHub stars](https://img.shields.io/github/stars/your-repo.svg?style=social)](https://github.com/sentanilesh007/dash_no_internet_screen)

A customizable **No Internet Screen** for Flutter apps with a reusable widget.  
When your app has no connectivity, instead of a boring static screen, you can show users with customizable text and image.

---

## ✨ Features
- 📱 Responsive layout (works on Android, iOS, Web, and Desktop)  
- 🖼️ Support for **custom image, and text**  
- 🔌 Auto-detects internet connectivity using [`connectivity_plus`](https://pub.dev/packages/connectivity_plus)  

---

## 📸 Screenshots
| No Internet Screen | Example Screen |
|--------------------|----------------|
| <img width="400" height="711" alt="no_internet_screen" src="https://github.com/user-attachments/assets/ca0139af-c384-4a61-af21-5a8568268ea8" /> | <img width="400" height="711" alt="test_screen" src="https://github.com/user-attachments/assets/a88c3f40-e99d-465e-9df5-725b61900265" /> |

---

## NO Internet Screen Package
```
import 'dart: async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package: flutter/material.dart';

class DashNoInterNetScreen extends StatefulWidget {
  final Widget child;
  final String? image;
  final String? text;
  const DashNoInterNetScreen({super.key, required this.child,this.image,this.text});

  @override
  State<DashNoInterNetScreen> createState() => _DashNoInterNetScreenState();
}

class _DashNoInterNetScreenState extends State<DashNoInterNetScreen> {
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
    checkInitialConnectivity();
  }
  
  /// check initial connectivity status
  Future<void> checkInitialConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    updateConnectionStatus(connectivityResult);
  }

  /// update connection status
  void updateConnectionStatus(List<ConnectivityResult> results) {
    final hasInternet = results.any((result) => result != ConnectivityResult.none);
    if (this.hasInternet != hasInternet) {
      setState(() {
        this.hasInternet = hasInternet;
      });
    }
  }

  /// show snackbar message
  void showSnackBar(String message, {Color color = Colors.red}) {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
    }
  }
  
  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasInternet) {
      return widget.child;
    } else {
      return buildNoInternetScreen(context);
    }
  }
  
/// no internet screen widget 
  Widget buildNoInternetScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.image?? "assets/no_internet.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              Text(
                widget.text ?? "No internet? Please Check Your Internet Connection!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final connectivityResult = await (Connectivity().checkConnectivity());
                  final hasInternet = connectivityResult.any((result) => result != ConnectivityResult.none);
                  if (hasInternet) {
                    setState(() {
                      this.hasInternet = true;
                    });
                    showSnackBar('Internet is now available!', color: Colors.green);
                  } else {
                    showSnackBar('No internet connection. Please try again.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

## ? How to use This Package
```
import 'package:flutter/material.dart';
import 'package:dash_no_internet_screen/dash_no_internet_screen.dart'; //import package

/// this is how to use in your app page for example
class TestScreen extends StatelessWidget {
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
```


## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  dash_no_internet_screen: ^0.0.1
