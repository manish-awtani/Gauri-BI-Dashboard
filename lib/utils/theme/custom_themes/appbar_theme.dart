import 'package:flutter/material.dart';
 
class SrkayAppBarTheme {
  SrkayAppBarTheme._();

    // ignore: prefer_const_constructors
    static final lightAppBarTheme = AppBarTheme(
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black, size: 24),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 24),
        titleTextStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      
    );

    // ignore: prefer_const_constructors
    static final darkAppBarTheme = AppBarTheme(
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black, size: 24),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 24),
        titleTextStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      
    );
}