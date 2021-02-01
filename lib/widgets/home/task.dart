import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

class Task extends StatelessWidget {
  final Map<String, dynamic> task;
  final int index;

  const Task(this.task, this.index);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = Provider.of<TaskProvider>(context, listen: true);
    final Size size = MediaQuery.of(context).size;

    final EdgeInsets contentPaddingDetails = EdgeInsets.symmetric(
        horizontal: size.width * 0.1, vertical: size.height * 0.01);

    final EdgeInsets contentPaddingNoDetails =
        EdgeInsets.symmetric(horizontal: size.width * 0.1);

    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) => state.markDone(index),
      direction: task['done'] == false ? DismissDirection.horizontal : null,
      background: Container(color: Colors.blue[600]),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: size.height * 0.013),
        child: ListTile(
          contentPadding: task['details'] != ''
              ? contentPaddingDetails
              : contentPaddingNoDetails,
          onTap: () => Navigator.pushNamed(
            context,
            '/details',
            arguments: {'task': task, 'index': index},
          ),
          title: Row(
            children: [
              _MarkDoneIcon(task, index),
              SizedBox(width: size.width * 0.04),
              _TaskBody(task),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskBody extends StatelessWidget {
  final Map<String, dynamic> task;

  const _TaskBody(this.task);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${task['title']}',
            style: TextStyle(
                fontSize: state.getAdaptiveTextSize(context, 15.0),
                decoration:
                    task['done'] == true ? TextDecoration.lineThrough : null,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        if (task['details'] != '') SizedBox(height: size.height * 0.005),
        if (task['details'] != '')
          Text('${task['details']}',
              style: TextStyle(
                fontSize: state.getAdaptiveTextSize(context, 13.0),
                color: Colors.grey,
              ))
      ],
    );
  }
}

class _MarkDoneIcon extends StatelessWidget {
  final Map<String, dynamic> task;
  final int index;

  const _MarkDoneIcon(this.task, this.index);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();

    return GestureDetector(
      onTap: () => state.markDone(index),
      child: Icon(
        task['done'] == true ? Icons.check : Icons.radio_button_unchecked,
        color: task['done'] == true ? Colors.blue : Colors.grey[700],
        size: state.getAdaptiveTextSize(context, 22),
      ),
    );
  }
}
