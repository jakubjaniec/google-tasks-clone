import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_tasks_clone/widgets/home/home_widgets.dart';
import 'package:google_tasks_clone/providers/task_provider.dart';

class PanelProvider {
  void openAddTaskPanel(BuildContext context) {
    context.read<TaskProvider>().taskTitle = '';
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => AddTaskPanel(),
    ));
  }

  void openMenu(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MenuPanel(),
    ));
  }

  void openOptions(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => OptionsPanel(),
    ));
  }
}
