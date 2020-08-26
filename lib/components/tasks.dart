import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final Map task;
  final int index;
  final Function markDone;

  Task(this.task, this.markDone, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, '/details'),
        title: Row(
          children: [
            IconButton(
              icon: task['done']
                  ? Icon(Icons.check, size: 24)
                  : Icon(Icons.radio_button_unchecked, size: 24),
              onPressed: () => markDone(index),
              color: task['done'] ? Colors.blue[400] : Colors.grey,
            ),
            Text(task['title'], style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class ActiveTasksList extends StatelessWidget {
  final List allTasks;
  final List tasks;
  final Function markDone;

  ActiveTasksList(this.allTasks, this.tasks, this.markDone);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        var index = allTasks.indexOf(task);

        return Task(task, markDone, index);
      }).toList(),
    );
  }
}

class DoneTasksList extends StatelessWidget {
  final List allTasks;
  final List tasks;
  final Function markDone;

  DoneTasksList(this.allTasks, this.tasks, this.markDone);

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
            title: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Completed (${tasks.length})',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            children: tasks.map((task) {
              var index = allTasks.indexOf(task);

              return Task(task, markDone, index);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
