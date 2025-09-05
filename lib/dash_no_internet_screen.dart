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
  final Widget? image;

  /// Vertical alignment of offline content.
  final MainAxisAlignment mainAxisAlignment;

  /// Horizontal alignment of offline content.
  final CrossAxisAlignment crossAxisAlignment;

  /// Message text shown when offline.
  final String? text;

  /// Alignment of the offline message.
  final TextAlign textAlign;

  /// Style for the offline message.
  final TextStyle? textStyle;

  /// Label for the retry button.
  final String buttonText;

  /// Style for retry button text.
  final TextStyle? buttonTextStyle;

  /// Background color of retry button.
  final Color buttonColor;

  /// Text color of retry button.
  final Color buttonTextColor;

  /// Padding inside retry button.
  final EdgeInsets buttonPadding;

  /// Custom [ButtonStyle] for retry button.
  final ButtonStyle? buttonStyle;

  /// Custom border shape for retry button.
  final RoundedRectangleBorder? buttonBorderShape;

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
    this.text,
    this.textStyle,
    this.buttonText = "Try Again",
    this.buttonTextStyle,
    this.buttonColor = Colors.blue,
    this.buttonTextColor = Colors.white,
    this.buttonPadding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    this.backgroundColor = Colors.white,
    this.onInternetAvailable,
    this.onRetryFailed,
    this.buttonStyle,
    this.buttonBorderShape,
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
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      updateConnectionStatus,
    );
    checkInitialConnectivity();
  }

  /// Checks internet connectivity when widget initializes.
  Future<void> checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
  }

  /// Updates [hasInternet] based on current [ConnectivityResult].
  void updateConnectionStatus(List<ConnectivityResult> results) {
    final hasInternet = results.any(
      (result) => result != ConnectivityResult.none,
    );
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
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Padding(
        padding: widget.padding,
        child: Column(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            // Custom image or default fallback network image
            widget.image ??
                Image.network(
                  'https://i.ibb.co/4W2DGKm/no-internet.png',
                  height: 150,
                  width: 150,
                ),
            SizedBox(height: widget.spacing),
            Text(
              widget.text ?? "No internet? Please check your connection!",
              style:
                  widget.textStyle ??
                  const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
              textAlign: widget.textAlign,
            ),
            SizedBox(height: widget.spacing),
            ElevatedButton(
              onPressed: () async {
                final connectivityResult = await Connectivity()
                    .checkConnectivity();
                final hasInternet = connectivityResult.any(
                  (result) => result != ConnectivityResult.none,
                );
                if (hasInternet) {
                  setState(() {
                    this.hasInternet = true;
                  });
                  widget.onInternetAvailable?.call();
                } else {
                  widget.onRetryFailed?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'No internet connection. Please try again.',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor,
                foregroundColor: widget.buttonTextColor,
                padding: widget.buttonPadding,
                shape:
                    widget.buttonBorderShape ??
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
              ),
              child: Text(
                widget.buttonText,
                style:
                    widget.buttonTextStyle ??
                    TextStyle(color: widget.buttonTextColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

