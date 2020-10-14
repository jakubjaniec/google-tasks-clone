import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:Google_Task_Clone/components/add_task_panel.dart';
import 'package:Google_Task_Clone/components/menu_panel.dart';
import 'package:Google_Task_Clone/components/options_panel.dart';

class TaskModel extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('tasks');

  List _tasks;

  void getData() async {
    await storage.ready;

    if (_tasks != null) return;

    if (storage.getItem('1') != null)
      _tasks = storage.getItem('1');
    else
      _tasks = [];

    notifyListeners();
  }

  get allTasks => _tasks;
  get activeTasks => _tasks.where((task) => !task['done']);
  get doneTasks => _tasks.where((task) => task['done']);

  List listTitles = ['Tasks', 'Shopping'];
  String taskTitle = '';

  void addTask(context) {
    _tasks.add(
        {'id': taskTitle, 'title': taskTitle, 'details': '', 'done': false});
    storage.setItem('1', _tasks);
    taskTitle = '';
    Navigator.pop(context);
    notifyListeners();
  }

  void addDetails(index, value) {
    _tasks[index]['details'] = value.toString();
    storage.setItem('1', _tasks);
    notifyListeners();
  }

  void editTaskTitle(index, value) {
    _tasks[index]['title'] = value.toString();
    storage.setItem('1', _tasks);
    notifyListeners();
  }

  void markDone(index, [context, route]) {
    _tasks[index]['done'] = !_tasks[index]['done'];
    storage.setItem('1', _tasks);

    if (route == 'details' && _tasks[index]['done']) Navigator.pop(context);
    notifyListeners();
  }

  void resetInput() {
    taskTitle = '';
    notifyListeners();
  }

  void deleteTask(context, index) {
    _tasks.removeAt(index);
    storage.setItem('1', _tasks);
    Navigator.pop(context);
    notifyListeners();
  }

  void handleInputValueChange(value) {
    taskTitle = value;
    notifyListeners();
  }

  void deleteDoneTasks(context) {
    _tasks.removeWhere((task) => task['done']);
    storage.setItem('1', _tasks);
    Navigator.pop(context);
    notifyListeners();
  }

  // bool isPanelOpen = false;

  void openAddTaskPanel(context) {
    // isPanelOpen = !isPanelOpen;
    notifyListeners();
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => AddTaskPanel(),
    ));
  }

  void openMenu(context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MenuPanel(),
    ));
  }

  void openOptions(context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => OptionsPanel(),
    ));
  }
}
