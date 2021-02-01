import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';
import 'package:Google_Task_Clone/widgets/home/task.dart';

class ActiveTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = Provider.of<TaskProvider>(context, listen: true);

    return state.activeTasks.isNotEmpty == true
        ? Column(
            children: state.activeTasks.map<Widget>((task) {
              final int index = state.allTasks.indexOf(task);

              return Task(task, index);
            }).toList(),
          )
        : Container();
  }
}

class DoneTasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600 ?? false;

    return state.doneTasks.isNotEmpty == true
        ? Column(
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
          )
        : Container();
  }
}
