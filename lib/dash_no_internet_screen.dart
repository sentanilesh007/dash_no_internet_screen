import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class DashNoInterNetScreen extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final String? image;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? imageHeight;
  final double? imageWidth;
  final String? text;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final String retryButtonText;
  final TextStyle? retryButtonTextStyle;
  final Color retryButtonColor;
  final Color retryButtonTextColor;
  final EdgeInsets retryButtonPadding;
  final ButtonStyle? retryButtonStyle;
  final RoundedRectangleBorder? retryButtonBorderShape;
  final Color backgroundColor;
  final double spacing;
  final VoidCallback? onInternetAvailable;
  final VoidCallback? onRetryFailed;

  const DashNoInterNetScreen({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.text,
    this.textStyle,
    this.retryButtonText = "Try Again",
    this.retryButtonTextStyle,
    this.retryButtonColor = Colors.blue,
    this.retryButtonTextColor = Colors.white,
    this.retryButtonPadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.backgroundColor = Colors.white,
    this.onInternetAvailable,
    this.onRetryFailed,
    this.retryButtonStyle,
    this.retryButtonBorderShape,
    this.spacing = 30,
    this.textAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

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
    final connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
  }

  /// update connection status
  void updateConnectionStatus(List<ConnectivityResult> results) {
    final hasInternet = results.any((result) => result != ConnectivityResult.none);
    if (this.hasInternet != hasInternet) {
      setState(() {
        this.hasInternet = hasInternet;
      });

      if (hasInternet && widget.onInternetAvailable != null) {
        widget.onInternetAvailable!();
      }
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
    final size = MediaQuery.of(context).size;
    final imageHeight = widget.imageHeight ?? size.height * 0.3;
    final imageWidth  = widget.imageWidth ?? size.width * 0.6;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Padding(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Image.asset(
              widget.image ?? "assets/no_internet.png",
              height: imageHeight,
              width: imageWidth,
            ),
             SizedBox(height: widget.spacing),
            Text(
              widget.text ?? "No internet? Please check your connection!",
              style: widget.textStyle ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
              textAlign: widget.textAlign,
            ),
             SizedBox(height: widget.spacing),
            ElevatedButton(
              onPressed: () async {
                final connectivityResult = await Connectivity().checkConnectivity();
                final hasInternet = connectivityResult.any((result) => result != ConnectivityResult.none);
                if (hasInternet) {
                  setState(() {
                    this.hasInternet = true;
                  });
                  widget.onInternetAvailable?.call();
                } else {
                  widget.onRetryFailed?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No internet connection. Please try again.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.retryButtonColor,
                foregroundColor: widget.retryButtonTextColor,
                padding: widget.retryButtonPadding,
                shape:  widget.retryButtonBorderShape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                widget.retryButtonText,
                style: widget.retryButtonTextStyle ?? TextStyle(color: widget.retryButtonTextColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
