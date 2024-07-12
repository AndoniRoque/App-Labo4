import 'package:flutter/material.dart';
import 'package:flutter_app_prototype/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          // primaryColor: Colors.black,
          // appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          // style: TextButton.styleFrom(
          // backgroundColor: Colors.black,
          // foregroundColor: Colors.black)),
          // textButtonTheme: TextButtonThemeData(
          // style: TextButton.styleFrom(
          // backgroundColor: Colors.black,
          // foregroundColor: Colors.black)),
          // floatingActionButtonTheme: const FloatingActionButtonThemeData(
          // backgroundColor: Colors.black, foregroundColor: Colors.white)),
          ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'range': (context) => DayRangePicturesPage(),
      },
    );
  }
}
