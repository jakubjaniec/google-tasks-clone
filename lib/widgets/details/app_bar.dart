import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, dynamic> task;
  final int index;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const DetailsAppBar(this.task, this.index);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey[700]),
      leading: Padding(
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: state.getAdaptiveTextSize(context, 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        IconButton(
          icon: task['done'] == true
              ? const Icon(Icons.undo)
              : const Icon(Icons.check),
          iconSize: state.getAdaptiveTextSize(context, 22),
          onPressed: () => state.markDone(index, context, 'details'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: IconButton(
            icon: const Icon(Icons.delete),
            iconSize: state.getAdaptiveTextSize(context, 22),
            onPressed: () => state.deleteTask(context, index),
          ),
        )
      ],
    );
  }
}
