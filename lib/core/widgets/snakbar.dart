import 'package:flutter/material.dart';

showSnakbar(
    BuildContext context, String message, Color? color, Duration? duration) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: color ?? Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

showConnectionSnakbar(BuildContext context, bool isNotConnected) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isNotConnected ? Colors.red : Colors.green,
      duration: Duration(seconds: isNotConnected ? 6000 : 1),
      content: Text(isNotConnected ? "no connection" : "connected",
          textAlign: TextAlign.center)));
}
