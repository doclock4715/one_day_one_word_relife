import 'package:flutter/material.dart';

BoxDecoration gradientBoxDecoration() {
    return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple, Colors.blue],
          ),
        );
  }