import 'package:flutter/material.dart';

BoxDecoration aBoxDecoration() {
  return BoxDecoration(
    // Background gradient
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(69, 255, 255, 255),
        Color.fromARGB(124, 238, 238, 238),
      ],
    ),
    // Rounded corners
    borderRadius: BorderRadius.circular(20),
    // Shadow to give depth
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.15),
        offset: Offset(0, 10),
        blurRadius: 20,
      ),
    ],
  );
}