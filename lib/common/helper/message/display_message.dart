import 'package:flutter/material.dart';

class DisplayMessage {
  static void errorMessage(String message, BuildContext context) {
    var snackbar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void successMessage(String message, BuildContext context) {
    var snackbar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
