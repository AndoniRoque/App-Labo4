import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_prototype/widgets/portraits.dart';
import 'package:flutter_app_prototype/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String explanation = "Loading...";
  String image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/NASA_logo.svg/800px-NASA_logo.svg.png';
  String title = 'Loading...';

  @override
  void initState() {
    super.initState();
    getFechaActual();
  }

  Future<void> getFechaActual() async {
    DateTime now = DateTime.now();
    String fechaActual = "${now.year}-${now.month}-${now.day}";
    final response = await http.get(Uri.parse('https://node-js-heroku.onrender.com/api/v1/nasa/picture/${fechaActual}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        explanation = data['explanation'];
        title = data['title'];
        image = data['url'];
      });
    } else {
      setState(() {
        explanation = "Failed to load explanation";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Portrait(urlImage: image),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0, color: Colors.blueAccent),
                ),
                margin: const EdgeInsets.all(20),
                child: Text(
                  explanation,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (currentIndex == 0) {
              Navigator.pushReplacementNamed(context, 'dayPicture');
            } else {
              Navigator.pushReplacementNamed(context, 'range');
            }
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Picture of the day',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Multiple Pictures',
          ),
        ],
      ),
    );
  }
}