import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/pages/home.dart';
import 'package:Google_Task_Clone/pages/details.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/details': (context) => Details(),
      },
    ),
  );
}
