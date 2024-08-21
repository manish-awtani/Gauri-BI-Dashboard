import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/services/dependecy_injection.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // setupLocator(); // Ensure GetIt is set up before running the app
  runApp(MyApp());
}
