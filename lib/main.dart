import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:Google_Task_Clone/pages/home.dart';
import 'package:Google_Task_Clone/pages/details.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    ScreenUtil.init(context, designSize: Size(320.0, 569.0));
    service.SystemChrome.setPreferredOrientations([
      service.DeviceOrientation.portraitUp,
      service.DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/details': (context) => Details(),
      },
    );
  }
}
