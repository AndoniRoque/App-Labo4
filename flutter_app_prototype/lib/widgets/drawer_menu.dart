import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const _DrawerHeader(),
      const Divider(height: 15),
      ListTile(
        title: const Text("Today's Picture"),
        subtitle: const Text('Home page'),
        leading: const Icon(Icons.adjust),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'home');
        },
      ),
      const Divider(height: 15),
      ListTile(
        title: const Text('Picture'),
        subtitle: const Text("Pick the date, get the picture"),
        leading: const Icon(Icons.adjust),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'harry');
        },
      ),
      const Divider(height: 15),
      ListTile(
        title: const Text('Pictures'),
        subtitle: const Text("Pick two dates, get all pictures"),
        leading: const Icon(Icons.adjust),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'skills');
        },
      ),
      const Divider(height: 15),
    ]));
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/nasa-logo.png'),
              fit: BoxFit.fitWidth,
              opacity: 0.9)),
      child: Container(
        alignment: Alignment.bottomLeft,
      ),
    );
  }
}
