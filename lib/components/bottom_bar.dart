import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskModel state = Provider.of<TaskModel>(context, listen: true);

    return BottomAppBar(
      elevation: 20.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 24.h,
              color: Colors.grey[600],
              icon: Icon(Icons.menu),
              onPressed: () => state.openMenu(context),
            ),
            IconButton(
              iconSize: 24.h,
              color: Colors.grey[600],
              icon: Icon(Icons.more_vert),
              onPressed: () => state.openOptions(context),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskPanelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);

    return SizedBox(
      height: 45.sp,
      width: 45.sp,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => state.openAddTaskPanel(context),
          child: Icon(
            Icons.add,
            color: Colors.blue[600],
            size: 35,
          ),
        ),
      ),
    );
  }
}
