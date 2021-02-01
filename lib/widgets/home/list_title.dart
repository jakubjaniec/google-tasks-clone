import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

class ListTitle extends StatelessWidget {
  final String activeList;

  const ListTitle(this.activeList);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.19, vertical: size.height * 0.03),
          child: Text(
            activeList,
            style: TextStyle(
              fontSize: state.getAdaptiveTextSize(context, 27),
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
