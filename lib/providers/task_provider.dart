import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class TaskProvider extends ChangeNotifier {
  final LocalStorage storage = LocalStorage('test');

  List<Map<String, dynamic>> _tasks;

  Future<void> getData() async {
    await storage.ready;

    if (_tasks != null) return;

    if (storage.getItem('tasks') != null) {
      final tasks = <Map<String, dynamic>>[...storage.getItem('tasks')];
      _tasks = tasks;
    } else {
      _tasks = [];
    }

    notifyListeners();
  }

  List<Map<String, dynamic>> get allTasks => _tasks;
  Iterable<Map<String, dynamic>> get activeTasks =>
      _tasks.where((task) => task['done'] == false);
  Iterable<Map<String, dynamic>> get doneTasks =>
      _tasks.where((task) => task['done'] == true);

  List listTitles = ['Tasks', 'Shopping'];
  String taskTitle = '';
  String taskDetails = '';

  void addTask(BuildContext context) {
    final Map<String, dynamic> task = {
      'id': taskTitle,
      'title': taskTitle,
      'details': taskDetails,
      'done': false,
    };
    final List<Map<String, dynamic>> tasks = [..._tasks, task];

    _tasks = tasks;
    storage.setItem('tasks', _tasks);
    taskTitle = '';
    Navigator.pop(context);
    notifyListeners();
  }

  void addDetails(int index, String value) {
    taskDetails = value;
    _tasks[index]['details'] = taskDetails;
    storage.setItem('tasks', _tasks);
    notifyListeners();
  }

  void editTaskTitle(int index, String value) {
    _tasks[index]['title'] = value;
    storage.setItem('tasks', _tasks);
    notifyListeners();
  }

  void markDone(int index, [BuildContext context, String route]) {
    _tasks[index]['done'] = _tasks[index]['done'] == false;
    storage.setItem('tasks', _tasks);

    if (route == 'details' && _tasks[index]['done'] == true) {
      Navigator.pop(context);
    } else if (route == 'details' && _tasks[index]['done'] == false) {
      Navigator.pop(context);
      Navigator.pushNamed(
        context,
        '/details',
        arguments: {'task': _tasks[index], 'index': index},
      );
    }
    notifyListeners();
  }

  void deleteTask(BuildContext context, int index) {
    _tasks.removeAt(index);
    storage.setItem('tasks', _tasks);
    Navigator.pop(context);
    notifyListeners();
  }

  void handleInputValueChange(String value) {
    taskTitle = value;
    notifyListeners();
  }

  void deleteDoneTasks(BuildContext context) {
    _tasks.removeWhere((task) => task['done'] == true);
    storage.setItem('tasks', _tasks);
    Navigator.pop(context);
    notifyListeners();
  }

  // void reorderList(int oldIndex, int newIndex) {
  //   if(newIndex > oldIndex) {
  //     newIndex -=1;
  //     final String newString = myC
  //   }
  // }

  double getAdaptiveTextSize(BuildContext context, double value) {
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
