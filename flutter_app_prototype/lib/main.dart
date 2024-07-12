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
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'range': (context) => const DayRangePicturesPage(),
        'dayPicture': (context) => const SingleDayPicturePage(),
        'singlePicture': (context) => const APictureFromRangePage(),
      },
    );
  }
}
