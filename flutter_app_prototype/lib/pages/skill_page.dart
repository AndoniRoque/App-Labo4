import 'package:flutter/material.dart';
import 'package:flutter_app_prototype/widgets/drawer_menu.dart';
import 'package:flutter_app_prototype/widgets/portraits.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['title'], style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: ListView(
        children: [
          Portrait(
              urlImage:
                  arguments['image']),
          Card(
            elevation: 1,
            color: Colors.blueAccent,
            child: ListTile(
              title: const Text(
                style: TextStyle(fontSize: 22, color: Colors.white),
                'Description\n'
              ),
              subtitle: Text(
                style: const TextStyle(fontSize: 20, color: Colors.white),
                arguments["description"].toString()
              )
            )
          )
        ],
      ),
    );
  }
}


