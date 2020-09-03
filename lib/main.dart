import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Google_Task_Clone/pages/home.dart';
import 'package:Google_Task_Clone/pages/details.dart';
import 'package:Google_Task_Clone/models.dart';

void main() {
  runApp(
    ChangeNotifierProvider.value(
      value: TaskModel(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/details': (context) => Details(),
        },
      ),
    ),
  );
}
