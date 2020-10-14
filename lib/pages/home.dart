import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/task_model.dart';

import 'package:Google_Task_Clone/components/task.dart';
import 'package:Google_Task_Clone/components/list_title.dart';
import 'package:Google_Task_Clone/components/bottom_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    state.getData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          state.allTasks != null
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
        ],
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: AddTaskPanelButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
