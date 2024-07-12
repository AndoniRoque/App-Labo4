import 'package:flutter/material.dart';
import 'package:flutter_app_prototype/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HarryPage extends StatefulWidget {
  const HarryPage({Key? key}) : super(key: key);

  @override
  State<HarryPage> createState() => _HarryPageState();
}
class _HarryPageState extends State<HarryPage> {
  int currentIndex = 0;
  String explanation = "Loading...";
  String image = '';
  String title = 'Loading...';
  DateTime? selectedDate;

  Future<void> getFechaIngresada(DateTime date) async {
    String formattedDate = '${date.year}-${date.month}-${date.day}';
    final apiUrl = 'https://node-js-heroku.onrender.com/api/v1/nasa/picture/$formattedDate';

    try {
      final response = await http.get(Uri.parse(apiUrl));

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
    } catch (e) {
      setState(() {
        explanation = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astronomy Picture of the Day', style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1996, 2, 21),
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blueGrey,
                            onPrimary: Colors.white,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blueGrey,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                    getFechaIngresada(pickedDate);
                  }
                },
                child: const Text('Seleccionar Fecha'),
              ),
              const SizedBox(height: 20),
              if (selectedDate != null)
                Column(
                  children: [
                    Portrait(urlImage: image),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0, color: Colors.blueGrey),
                      ),
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            explanation,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
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
              Navigator.pushReplacementNamed(context, 'harry');
            } else {
              Navigator.pushReplacementNamed(context, 'skills');
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