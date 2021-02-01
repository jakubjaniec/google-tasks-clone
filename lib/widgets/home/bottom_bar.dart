import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/panel_provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final PanelProvider panelOptions = context.watch<PanelProvider>();
    final Size size = MediaQuery.of(context).size;

    return BottomAppBar(
      elevation: 20.0,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.004, horizontal: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: state.getAdaptiveTextSize(context, 24),
              color: Colors.grey[600],
              icon: const Icon(Icons.menu),
              onPressed: () => panelOptions.openMenu(context),
            ),
            IconButton(
              iconSize: state.getAdaptiveTextSize(context, 24),
              color: Colors.grey[600],
              icon: const Icon(Icons.more_vert),
              onPressed: () => panelOptions.openOptions(context),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskPanelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final PanelProvider panelOptions = context.watch<PanelProvider>();
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.08,
      width: size.height * 0.08,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => panelOptions.openAddTaskPanel(context),
          child: Icon(
            Icons.add,
            color: Colors.blue[600],
            size: state.getAdaptiveTextSize(context, 34),
          ),
        ),
      ),
    );
  }
}
