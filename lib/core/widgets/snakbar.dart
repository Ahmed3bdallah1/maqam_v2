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
