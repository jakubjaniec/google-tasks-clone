import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/task_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Task extends StatelessWidget {
  final Map task;
  final int index;

  Task(this.task, this.index);

  final EdgeInsets contentPaddingDetails =
      EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 5.0.h);
  final EdgeInsets contentPaddingNoDetails =
      EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 0.0);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var isTablet = width >= 600 ? true : false;

    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) => state.markDone(index),
      direction: !task['done'] ? DismissDirection.horizontal : null,
      background: Container(color: Colors.blue[600]),
      child: Card(
        elevation: 0,
        margin:
            EdgeInsets.symmetric(horizontal: 0, vertical: isTablet ? 5.0.h : 0),
        child: ListTile(
          contentPadding: task['details'] != ''
              ? contentPaddingDetails
              : contentPaddingNoDetails,
          onTap: () => Navigator.pushNamed(
            context,
            '/details',
            arguments: {
              'task': task,
              'index': index,
            },
          ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () => state.markDone(index),
                child: Icon(
                  task['done'] ? Icons.check : Icons.radio_button_unchecked,
                  color: task['done'] ? Colors.blue : Colors.grey[700],
                  size: !isTablet ? 23.sp : 20.sp,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['title'].toString(),
                      style: TextStyle(
                          fontSize: !isTablet ? 15.sp : 14.sp,
                          decoration:
                              task['done'] ? TextDecoration.lineThrough : null,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  task['details'] != '' ? SizedBox(height: 5.0) : Container(),
                  task['details'] != ''
                      ? Text(task['details'],
                          style: TextStyle(
                            fontSize: !isTablet ? 13.sp : 12.sp,
                            color: Colors.grey,
                          ))
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    return state.activeTasks.length > 0
        ? Column(
            children: state.activeTasks.map<Widget>((task) {
              var index = state.allTasks.indexOf(task);

              return Task(task, index);
            }).toList(),
          )
        : Container();
  }
}

class DoneTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    bool isTablet = width >= 600 ? true : false;

    return state.doneTasks.length > 0
        ? Column(
            children: [
              Divider(),
              Theme(
                data: ThemeData(
                  dividerColor: Colors.transparent,
                  accentColor: Colors.black,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(
                      horizontal: 30.h, vertical: isTablet ? 5.h : 0),
                  title: Text(
                    'Completed (${state.doneTasks.length})',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: !isTablet ? 15.0.sp : 13.5.sp),
                  ),
                  children: state.doneTasks.map<Widget>((task) {
                    var index = state.allTasks.indexOf(task);

                    return Task(task, index);
                  }).toList(),
                ),
              ),
            ],
          )
        : Container();
  }
}
