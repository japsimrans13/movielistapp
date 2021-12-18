//palette.dart
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor ProjectThemeColor = const MaterialColor(
    0xffffd800, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffe6c200), //10%
      100: const Color(0xffccad00), //20%
      200: const Color(0xffb39700), //30%
      300: const Color(0xff998200), //40%
      400: const Color(0xff806c00), //50%
      500: const Color(0xff665600), //60%
      600: const Color(0xff4c4100), //70%
      700: const Color(0xff332b00), //80%
      800: const Color(0xff191600), //90%
      900: const Color(0xff000000), //100%
    },
  );
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below.
