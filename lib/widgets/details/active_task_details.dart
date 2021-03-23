import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_tasks_clone/providers/task_provider.dart';
import 'package:google_tasks_clone/widgets/details/details_widgets.dart';

class ActiveTaskDetails extends StatelessWidget {
  final dynamic task;
  final dynamic index;

  const ActiveTaskDetails(this.task, this.index);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
          child: TextFormField(
            onChanged: (value) => state.editTaskTitle(index as int, value),
            style: TextStyle(
                fontSize: state.getAdaptiveTextSize(context, 24),
                fontWeight: FontWeight.w500),
            initialValue: '${task['title']}',
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Option(
                'Add details', Icons.sort, 'details', index, task['details']),
            const Option('Add date/hour', Icons.event_available, 'date'),
            const Option(
                'Add subtasks', Icons.subdirectory_arrow_right, 'subtasks'),
          ],
        )
      ],
    );
  }
}
