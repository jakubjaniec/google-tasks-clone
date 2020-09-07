import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:Google_Task_Clone/components/addTaskPanel.dart';
import 'package:Google_Task_Clone/components/menuPanel.dart';
import 'package:Google_Task_Clone/components/optionsPanel.dart';

class TaskModel extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('tasks');

  List tasks;
  void getData() async {
    await storage.ready;
    storage.clear();

    if (tasks != null) return;

    if (storage.getItem('1') != null)
      tasks = storage.getItem('1');
    else
      tasks = [];

    notifyListeners();
  }

  get allTasks => tasks;
  get activeTasks => tasks.where((task) => !task['done']);
  get doneTasks => tasks.where((task) => task['done']);

  var maxHeight;
  var listTitles = ['Tasks', 'Shopping'];
  String inputValue = '';

  void addTask(context) {
    tasks.add({'id': inputValue, 'title': inputValue, 'done': false});
    storage.setItem('1', tasks);
    inputValue = '';
    Navigator.pop(context);
    notifyListeners();
  }

  void markDone(index, [context, route]) {
    tasks[index]['done'] = !tasks[index]['done'];
    storage.setItem('1', tasks);

    if (route == 'details' && tasks[index]['done']) Navigator.pop(context);
    notifyListeners();
  }

  void deleteTask(index) {
    tasks.removeAt(index);
    storage.setItem('1', tasks);
    notifyListeners();
  }

  void handleInputValueChange(value) {
    inputValue = value;
    notifyListeners();
  }

  void deleteDoneTasks(context) {
    tasks.removeWhere((task) => task['done']);
    storage.setItem('1', tasks);
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
      pageBuilder: (_, __, ___) => MenuPanel('Tasks'),
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
