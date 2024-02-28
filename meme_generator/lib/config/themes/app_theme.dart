import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      scaffoldBackgroundColor: Colors.grey[900],
      useMaterial3: true
  );
}
