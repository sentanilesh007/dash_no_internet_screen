import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// A widget that automatically detects internet connectivity
/// and shows a customizable **No Internet Screen** when offline.
///
/// Wrap your app or any screen with [DashNoInterNetScreen] to handle
/// connectivity state changes out-of-the-box.
class DashNoInterNetScreen extends StatefulWidget {
  /// The main widget to show when internet is available.
  final Widget child;

  /// Padding for the offline content.
  final EdgeInsets padding;

  /// Image asset path for the offline illustration.
  final String? image;

  /// Vertical alignment of offline content.
  final MainAxisAlignment mainAxisAlignment;

  /// Horizontal alignment of offline content.
  final CrossAxisAlignment crossAxisAlignment;

  /// Height of the offline image.
  final double? imageHeight;

  /// Width of the offline image.
  final double? imageWidth;

  /// Message text shown when offline.
  final String? text;

  /// Alignment of the offline message.
  final TextAlign textAlign;

  /// Style for the offline message.
  final TextStyle? textStyle;

  /// Label for the retry button.
  final String retryButtonText;

  /// Style for retry button text.
  final TextStyle? retryButtonTextStyle;

  /// Background color of retry button.
  final Color retryButtonColor;

  /// Text color of retry button.
  final Color retryButtonTextColor;

  /// Padding inside retry button.
  final EdgeInsets retryButtonPadding;

  /// Custom [ButtonStyle] for retry button.
  final ButtonStyle? retryButtonStyle;

  /// Custom border shape for retry button.
  final RoundedRectangleBorder? retryButtonBorderShape;

  /// Background color of the offline screen.
  final Color backgroundColor;

  /// Vertical spacing between widgets in offline screen.
  final double spacing;

  /// Callback fired when internet becomes available.
  final VoidCallback? onInternetAvailable;

  /// Callback fired when retry fails (still no internet).
  final VoidCallback? onRetryFailed;

  /// Creates a [DashNoInterNetScreen].
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

  /// Checks internet connectivity when widget initializes.
  Future<void> checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
  }

  /// Updates [hasInternet] based on current [ConnectivityResult].
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

  /// Builds the "No Internet" screen UI.
  Widget buildNoInternetScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = widget.imageHeight ?? size.height * 0.3;
    final imageWidth = widget.imageWidth ?? size.width * 0.6;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Padding(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Image.asset(widget.image ?? "assets/no_internet.png", height: imageHeight, width: imageWidth),
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No internet connection. Please try again.')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.retryButtonColor,
                foregroundColor: widget.retryButtonTextColor,
                padding: widget.retryButtonPadding,
                shape: widget.retryButtonBorderShape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(widget.retryButtonText, style: widget.retryButtonTextStyle ?? TextStyle(color: widget.retryButtonTextColor, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
