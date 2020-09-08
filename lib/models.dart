import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:Google_Task_Clone/components/addTaskPanel.dart';
import 'package:Google_Task_Clone/components/menuPanel.dart';
import 'package:Google_Task_Clone/components/optionsPanel.dart';

class TaskModel extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('_tasks');

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

  var maxHeight;
  var listTitles = ['Tasks', 'Shopping'];
  String taskTitle = '';
  String taskDetails = '';

  void addTask(context) {
    _tasks.add(
        {'id': taskTitle, 'title': taskTitle, 'details': '', 'done': false});
    storage.setItem('1', _tasks);
    taskTitle = '';
    Navigator.pop(context);
    notifyListeners();
  }

  void addDetails(index, value) {
    _tasks[index]['details'] = value;
    storage.setItem('1', _tasks);
    notifyListeners();
  }

  void markDone(index, [context, route]) {
    _tasks[index]['done'] = !_tasks[index]['done'];
    storage.setItem('1', _tasks);

    if (route == 'details' && _tasks[index]['done']) Navigator.pop(context);
    notifyListeners();
  }

  void deleteTask(index) {
    _tasks.removeAt(index);
    storage.setItem('1', _tasks);
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

  void openAddTaskPanel(context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => AddTaskPanel(),
    ));
  }

  void openMenu(context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MenuPanel('_tasks'),
    ));
  }

  void openOptions(context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => OptionsPanel(),
    ));
  }

  void maxHeightPicker(height) {
    switch (listTitles.length) {
      case 1:
        maxHeight = height / 2.5;
        break;
      case 2:
        maxHeight = height / 2.1;
        break;
      case 3:
        maxHeight = height / 1.8;
        break;
      case 4:
        maxHeight = height / 1.6;
        break;
      case 5:
        maxHeight = height / 1.4;
        break;
      default:
        maxHeight = height;
        break;
    }
  }
}
