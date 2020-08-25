import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/components/tasks.dart';
import 'package:Google_Task_Clone/components/listTitle.dart';
import 'package:Google_Task_Clone/components/bottomBar.dart';

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

  List activeTasks = allTasks.where((task) => !task['done']).toList();
  List doneTasks = allTasks.where((task) => task['done']).toList();

  void updateTasks() {
    setState(() {
      activeTasks = allTasks.where((task) => !task['done']).toList();
      doneTasks = allTasks.where((task) => task['done']).toList();
    });
  }

  void markDone(index) {
    setState(() {
      allTasks[index]['done'] = !allTasks[index]['done'];
    });
    updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTitle(),
            ActiveTasksList(allTasks, activeTasks, markDone),
            DoneTasksList(allTasks, doneTasks, markDone),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: AddTaskPanelButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
