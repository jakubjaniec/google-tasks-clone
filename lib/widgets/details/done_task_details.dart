import 'package:Google_Task_Clone/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneTaskDetails extends StatelessWidget {
  final dynamic task;

  const DoneTaskDetails(this.task);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
      child: Text("${task['title']}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: state.getAdaptiveTextSize(context, 24),
              decoration: TextDecoration.lineThrough)),
    );
  }
}
