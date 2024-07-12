import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_prototype/widgets/widgets.dart';

class DayRangePicturesPage extends StatefulWidget {
  const DayRangePicturesPage({Key? key}) : super(key: key);

  @override
  State<DayRangePicturesPage> createState() => _DayRangePicturesPageState();
}

class _DayRangePicturesPageState extends State<DayRangePicturesPage> {
  int currentIndex = 0;
  List<dynamic> nasaPictures = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> fetchNASAPicturesRange(DateTime end, DateTime start) async {
    String formattedStartDate = '${start.year}-${start.month}-${start.day}';
    String formattedEndDate = '${end.year}-${end.month}-${end.day}';

    print(formattedStartDate);
    print(formattedEndDate);

    final apiUrl = 'https://node-js-heroku.onrender.com/api/v1/nasa/pictures_range?start_date=$formattedStartDate&end_date=$formattedEndDate';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>(); // Convertir la lista JSON a una lista de Map<String, dynamic>
      setState(() {
        nasaPictures = data;
      });
    } catch (e) {
      print('Exception: $e');
      setState(() {
        nasaPictures = [];
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
                  final List<DateTime?> pickedDates = await Future.wait([
                    showDatePicker(
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
                    ),
                    showDatePicker(
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
                    ),
                  ]);

                  if (pickedDates[0] != null && pickedDates[1] != null) {
                    setState(() {
                      startDate = pickedDates[0]!;
                      endDate = pickedDates[1]!;
                      fetchNASAPicturesRange(startDate, endDate);
                    });
                  }
                },
                child: const Text('Seleccionar Fechas'),
              ),
              const SizedBox(height: 20),
              if (nasaPictures.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true, // Prevent ListView from expanding infinitely
                  physics: const NeverScrollableScrollPhysics(), // Prevent ListView from scrolling
                  itemCount: nasaPictures.length,
                  itemBuilder: (context, index) {
                    final image = nasaPictures[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'singlePicture',
                            arguments: {
                              'title': image['title'],
                              'description': image['explanation'],
                              'index': index,
                              'image': image['url'],
                            });
                      },
                      child: Container(
                          height: 90,
                          width: 350,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                    offset: Offset(0, 3))
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(image['title'],
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontFamily: 'changa')),
                                      Text(
                                          "Date: ${image['date']}",
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 18)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.8,
                                              color: Colors.red)),
                                      child: Image.network(image['url'])
                                  ),
                                )
                              ]
                          )
                      ),
                    );
                  },
                ),
              if (nasaPictures.isEmpty)
                const Center(
                  child: Text('Selecciona un rango de fechas para ver las imágenes de NASA', textAlign: TextAlign.center,),
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
