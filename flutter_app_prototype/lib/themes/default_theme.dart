import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light, // Añadir el valor de brightness
    primary: Color(0xff616161),
    onPrimary: Colors.white, // Definir el color onPrimary
    secondary: Color(0xffe65100),
    onSecondary: Colors.white, // Definir el color onSecondary
    error: Colors.red, // Definir el color error
    onError: Colors.white, // Definir el color onError
    background: Colors.white, // Definir el color background
    onBackground: Colors.black, // Definir el color onBackground
    surface: Colors.grey, // Definir el color surface
    onSurface: Colors.black, // Definir el color onSurface
  ),
  fontFamily: 'cardo',
);
