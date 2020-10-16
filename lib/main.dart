import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/pages/home.dart';
import 'package:Google_Task_Clone/pages/details.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    ChangeNotifierProvider.value(
      value: TaskModel(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    service.SystemChrome.setPreferredOrientations([
      service.DeviceOrientation.portraitUp,
      service.DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/details': (context) => Details(),
      },
    );
  }
}
