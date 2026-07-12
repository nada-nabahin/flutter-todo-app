import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/welcome_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? savedName = prefs.getString('userName');

  runApp(
    MaterialApp(
      home: savedName != null && savedName.isNotEmpty
          ? HomeScreen(userName: savedName)
          : const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
    ),
  );
}
