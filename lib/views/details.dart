import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';
import 'package:Google_Task_Clone/widgets/details/details_widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context).settings.arguments as Map;
    final Map<String, dynamic> task = args['task'] as Map<String, dynamic>;
    final int index = args['index'] as int;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: DetailsAppBar(task, index),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.04, vertical: size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ListName(),
            if (task['done'] == true)
              DoneTaskDetails(task)
            else
              ActiveTaskDetails(task, args['index']),
          ],
        ),
      ),
    );
  }
}

class _ListName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();

    return Row(children: [
      Text('Tasks',
          style: TextStyle(
              fontSize: state.getAdaptiveTextSize(context, 14),
              fontWeight: FontWeight.w700,
              color: Colors.blue[800])),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: state.getAdaptiveTextSize(context, 24),
        color: Colors.blue[800],
      )
    ]);
  }
}
