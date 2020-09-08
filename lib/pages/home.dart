import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/models.dart';

import 'package:Google_Task_Clone/components/tasks.dart';
import 'package:Google_Task_Clone/components/listTitle.dart';
import 'package:Google_Task_Clone/components/bottomBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    state.getData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: state.allTasks != null
          ? SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTitle('Tasks'),
                  ActiveTasksList(),
                  DoneTasksList(),
                ],
              ),
            ))
          : Container(),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: AddTaskPanelButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
