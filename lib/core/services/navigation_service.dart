import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  // Navigate to a named route
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Navigate and replace current route
  static Future<dynamic> navigateAndReplace(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  // Navigate and clear all previous routes
  static Future<dynamic> navigateAndClearAll(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // Go back
  static void goBack([dynamic result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    }
  }

  // Go back until a specific route
  static void goBackUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  // Check if can go back
  static bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }

  // Show dialog
  static Future<T?> showDialogWidget<T>(Widget dialog) {
    return showDialog<T>(
      context: navigatorKey.currentContext!,
      builder: (context) => dialog,
    );
  }

  // Show bottom sheet
  static Future<T?> showBottomSheetWidget<T>(Widget bottomSheet) {
    return showModalBottomSheet<T>(
      context: navigatorKey.currentContext!,
      builder: (context) => bottomSheet,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Show snackbar
  static void showSnackBar(String message, {Color? backgroundColor, Duration? duration}) {
    final scaffoldMessenger = ScaffoldMessenger.of(navigatorKey.currentContext!);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Show success message
  static void showSuccess(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  // Show error message
  static void showError(String message) {
    showSnackBar(message, backgroundColor: Colors.red);
  }

  // Show info message
  static void showInfo(String message) {
    showSnackBar(message, backgroundColor: Colors.blue);
  }

  // Show warning message
  static void showWarning(String message) {
    showSnackBar(message, backgroundColor: Colors.orange);
  }
}
