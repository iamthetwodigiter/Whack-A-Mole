import 'package:flutter/material.dart';
import 'package:whack_a_mole/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Riffic',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.amber, fontSize: 30, fontFamily: 'Riffic'),
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 25,
          ),
          labelLarge: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
