import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/components/addTaskPanel.dart';
import 'package:Google_Task_Clone/components/menuPanel.dart';
import 'package:Google_Task_Clone/components/optionsPanel.dart';

class TaskModel extends ChangeNotifier {
  String inputValue = '';
  List _tasks = [
    {'id': '1', 'title': 'Test1', 'done': false},
    {'id': '2', 'title': 'Test2', 'done': false},
    {'id': '3', 'title': 'Test3', 'done': false},
    {'id': '4', 'title': 'Test4', 'done': true},
  ];
  get allTasks => _tasks;
  get activeTasks => _tasks.where((task) => !task['done']);
  get doneTasks => _tasks.where((task) => task['done']);

  void addTask(context) {
    _tasks.add({'id': inputValue, 'title': inputValue, 'done': false});
    inputValue = '';
    Navigator.pop(context);
    notifyListeners();
  }

  void markDone(index, [context, route]) {
    _tasks[index]['done'] = !_tasks[index]['done'];

    if (route == 'details' && _tasks[index]['done']) Navigator.pop(context);

    notifyListeners();
  }

  void deleteTask(index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void handleInputValueChange(value) {
    inputValue = value;
    notifyListeners();
  }

  void deleteDoneTasks(context) {
    _tasks.removeWhere((task) => task['done']);
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
}
