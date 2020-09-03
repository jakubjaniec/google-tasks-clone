import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/components/tasks.dart';
import 'package:Google_Task_Clone/components/listTitle.dart';
import 'package:Google_Task_Clone/components/bottomBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String activeList = 'Tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTitle(activeList),
              ActiveTasksList(),
              DoneTasksList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: AddTaskPanelButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
