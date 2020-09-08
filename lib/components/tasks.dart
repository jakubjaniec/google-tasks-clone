import 'package:flutter/material.dart';

import 'package:Google_Task_Clone/models.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final Map task;
  final int index;

  Task(this.task, this.index);

  final EdgeInsets contentPaddingDetails =
      EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0);
  final EdgeInsets contentPaddingNoDetails =
      EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);

    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) => state.markDone(index),
      direction: !task['done'] ? DismissDirection.horizontal : null,
      background: Container(color: Colors.blue[600]),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 0),
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
                  size: 23,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['title'],
                      style: TextStyle(
                          fontSize: 15,
                          decoration:
                              task['done'] ? TextDecoration.lineThrough : null,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  task['details'] != '' ? SizedBox(height: 5.0) : Container(),
                  task['details'] != ''
                      ? Text(task['details'],
                          style: TextStyle(
                            fontSize: 13,
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
    return Column(
      children: state.activeTasks.map<Widget>((task) {
        var index = state.allTasks.indexOf(task);

        return Task(task, index);
      }).toList(),
    );
  }
}

class DoneTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);

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
                  tilePadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Completed (${state.doneTasks.length})',
                    style: TextStyle(fontWeight: FontWeight.w700),
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
