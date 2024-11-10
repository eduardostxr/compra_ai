import 'package:flutter/material.dart';

class SnackBarService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSuccess(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void showError(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void showInfo(String message) {
    _showSnackBar(
      message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  static void _showSnackBar(String message,
      {required Color backgroundColor, required IconData icon}) {
    final messenger = messengerKey.currentState;

    messenger?.hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    );

    messenger?.showSnackBar(snackBar);
  }
}
