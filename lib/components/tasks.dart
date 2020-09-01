import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final Map task;
  final int index;
  final Function markDone;
  final Function deleteTask;

  Task(this.task, this.markDone, this.index, this.deleteTask);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) => markDone(index),
      direction: !task['done'] ? DismissDirection.horizontal : null,
      background: Container(color: Colors.blue[600]),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30),
          onTap: () => Navigator.pushNamed(
            context,
            '/details',
            arguments: {
              'task': task,
              'markDone': markDone,
              'index': index,
              'deleteTask': deleteTask
            },
          ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () => markDone(index),
                child: Icon(
                  task['done'] ? Icons.check : Icons.radio_button_unchecked,
                  color: task['done'] ? Colors.blue : Colors.grey[700],
                  size: 22,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(task['title'],
                  style: TextStyle(
                      fontSize: 15,
                      decoration:
                          task['done'] ? TextDecoration.lineThrough : null,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveTasksList extends StatelessWidget {
  final List allTasks;
  final List tasks;
  final Function markDone;
  final Function deleteTask;

  ActiveTasksList(this.allTasks, this.tasks, this.markDone, this.deleteTask);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        var index = allTasks.indexOf(task);

        return Task(task, markDone, index, deleteTask);
      }).toList(),
    );
  }
}

class DoneTasksList extends StatelessWidget {
  final List allTasks;
  final List tasks;
  final Function markDone;
  final Function deleteTask;

  DoneTasksList(this.allTasks, this.tasks, this.markDone, this.deleteTask);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              'Completed (${tasks.length})',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            children: tasks.map((task) {
              var index = allTasks.indexOf(task);

              return Task(task, markDone, index, deleteTask);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
