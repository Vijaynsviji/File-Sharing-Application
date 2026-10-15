import 'package:flutter/material.dart';

class NotificationService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  // 🟢 Add a navigator key to handle dialogs globally
  static final navigatorKey = GlobalKey<NavigatorState>();

  // --- SnackBar Methods ---
  static void showSuccess(String message) => _showMessage(message, Colors.green);
  static void showError(String message) => _showMessage(message, Colors.red);

  static void _showMessage(String message, Color color) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
  }

  // --- Dialog Methods ---
  static void showSuccessDialog(String message, {int durationSeconds = 3}) {
    _showAutoCloseDialog('Success', message, Colors.green, Icons.check_circle, durationSeconds);
  }

  static void showErrorDialog(String message, {int durationSeconds = 3}) {
    _showAutoCloseDialog('Error', message, Colors.red, Icons.error, durationSeconds);
  }

  static void showWarningDialog(String message, {int durationSeconds = 3}) {
    _showAutoCloseDialog('Warning', message, Colors.orange, Icons.warning, durationSeconds);
  }

  static void _showAutoCloseDialog(
      String title,
      String message,
      Color color,
      IconData icon,
      int durationSeconds,
      ) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    bool isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: true, // Lets the user tap outside to close immediately
      builder: (BuildContext dialogContext) {

        // 🟢 Auto-close timer
        Future.delayed(Duration(seconds: durationSeconds), () {
          // Check if the dialog is still open before trying to pop it
          if (isDialogOpen && dialogContext.mounted) {
            isDialogOpen = false;
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                if (isDialogOpen) {
                  isDialogOpen = false;
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    ).then((_) {
      // 🟢 This triggers if the user taps outside the dialog to dismiss it.
      // It prevents the Future.delayed from popping the wrong screen later.
      isDialogOpen = false;
    });
  }
}