import 'package:flutter/material.dart';

class Portrait extends StatelessWidget {
  final String urlImage;
  const Portrait({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 4.0, color: Colors.red),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(226, 233, 215, .4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Image.network(urlImage),
        ),
      ],
    );
  }
}