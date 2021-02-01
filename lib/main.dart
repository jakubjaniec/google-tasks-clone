import 'package:Google_Task_Clone/providers/panel_provider.dart';
import 'package:device_preview/plugins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/views/home.dart';
import 'package:Google_Task_Clone/views/details.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(),
        ),
        Provider<PanelProvider>(
          create: (_) => PanelProvider(),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        plugins: const [
          ScreenshotPlugin(),
        ],
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
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}
