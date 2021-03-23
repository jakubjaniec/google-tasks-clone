import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_tasks_clone/providers/task_provider.dart';
import 'package:google_tasks_clone/widgets/home/task.dart';

class ActiveTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();

    if (state.activeTasks.isNotEmpty == true) {
      return Column(
        children: state.activeTasks.map<Widget>((task) {
          final int index = state.allTasks.indexOf(task);

          return Task(task, index);
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}

class DoneTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600 ?? false;

    if (state.doneTasks.isNotEmpty == true) {
      return Column(
        children: [
          const Divider(),
          Theme(
            data: ThemeData(
              dividerColor: Colors.transparent,
              accentColor: Colors.black,
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.11,
                  vertical: !isTablet ? 0 : size.height * 0.01),
              title: Text(
                'Completed (${state.doneTasks.length})',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: state.getAdaptiveTextSize(context, 16)),
              ),
              children: state.doneTasks.map<Widget>((task) {
                final int index = state.allTasks.indexOf(task);

                return Task(task, index);
              }).toList(),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
