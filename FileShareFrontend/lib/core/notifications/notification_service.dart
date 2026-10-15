import 'package:flutter/material.dart';

class NotificationService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final navigatorKey = GlobalKey<NavigatorState>();

  // --- SnackBar Methods ---
  static void showSuccess(String message) =>
      _showMessage(message, Colors.green);
  static void showError(String message) => _showMessage(message, Colors.red);

  static void _showMessage(String message, Color color) {
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  // --- Dialog Methods ---
  // 🟢 Added delayMs parameter with a default of 250ms
  static void showSuccessDialog(
    String message, {
    int durationSeconds = 3,
    int delayMs = 250,
  }) {
    _showAutoCloseDialog(
      'Success',
      message,
      Colors.green,
      Icons.check_circle,
      durationSeconds,
      delayMs,
    );
  }

  static void showErrorDialog(
    String message, {
    int durationSeconds = 3,
    int delayMs = 250,
  }) {
    _showAutoCloseDialog(
      'Error',
      message,
      Colors.red,
      Icons.error,
      durationSeconds,
      delayMs,
    );
  }

  static void showWarningDialog(
    String message, {
    int durationSeconds = 3,
    int delayMs = 250,
  }) {
    _showAutoCloseDialog(
      'Warning',
      message,
      Colors.orange,
      Icons.warning,
      durationSeconds,
      delayMs,
    );
  }

  static Future<void> _showAutoCloseDialog(
    String title,
    String message,
    Color color,
    IconData icon,
    int durationSeconds,
    int delayMs,
  ) async {
    // 🟢 Wait for the specified delay before attempting to show the dialog
    if (delayMs > 0) {
      await Future.delayed(Duration(milliseconds: delayMs));
    }

    // 🟢 Check context AFTER the delay to ensure the app is still active/mounted
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    bool isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        Future.delayed(Duration(seconds: durationSeconds), () {
          if (isDialogOpen && dialogContext.mounted) {
            isDialogOpen = false;
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
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
      isDialogOpen = false;
    });
  }
}
