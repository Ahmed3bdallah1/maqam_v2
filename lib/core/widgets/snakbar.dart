import 'package:flutter/material.dart';

showSnakbar(BuildContext context,String message,Color? color){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: color?? Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}