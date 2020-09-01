import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/components/tasks.dart';
import 'package:Google_Task_Clone/components/listTitle.dart';
import 'package:Google_Task_Clone/components/bottomBar.dart';
import 'package:Google_Task_Clone/components/addTaskPanel.dart';
import 'package:Google_Task_Clone/components/menuPanel.dart';
import 'package:Google_Task_Clone/components/optionsPanel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List allTasks = [
    {'id': '1', 'title': 'Test1', 'done': false},
    {'id': '2', 'title': 'Test2', 'done': false},
    {'id': '3', 'title': 'Test3', 'done': false},
    {'id': '4', 'title': 'Test4', 'done': true},
  ];

  String inputValue = '';
  String activeList = 'Tasks';

  List activeTasks = allTasks.where((task) => !task['done']).toList();
  List doneTasks = allTasks.where((task) => task['done']).toList();

  void updateTasks() {
    setState(() {
      activeTasks = allTasks.where((task) => !task['done']).toList();
      doneTasks = allTasks.where((task) => task['done']).toList();
    });
  }

  void markDone(index, [route]) {
    setState(() {
      allTasks[index]['done'] = !allTasks[index]['done'];
    });
    updateTasks();

    if (route == 'details') {
      Navigator.pop(context);
    }
  }

  void deleteTask(index, [route]) {
    setState(() {
      allTasks.removeAt(index);
    });
    updateTasks();

    if (route == 'details') {
      Navigator.pop(context);
    }
  }

  void handleInputValue(value) {
    setState(() {
      inputValue = value;
    });
  }

  void addTask() {
    setState(() {
      allTasks.add({'id': inputValue, 'title': inputValue, 'done': false});
      inputValue = '';
    });
    Navigator.pop(context);
    updateTasks();
  }

  void openAddTaskPanel() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => AddTaskPanel(handleInputValue, addTask),
    ));
  }

  void openMenu() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MenuPanel(activeList),
    ));
  }

  void openOptions() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => OptionsPanel(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTitle(activeList),
              ActiveTasksList(allTasks, activeTasks, markDone, deleteTask),
              DoneTasksList(allTasks, doneTasks, markDone, deleteTask),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(openMenu, openOptions),
      floatingActionButton: AddTaskPanelButton(openAddTaskPanel),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
