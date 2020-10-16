import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Google_Task_Clone/task_model.dart';
import 'package:provider/provider.dart';

class ListTitle extends StatelessWidget {
  final String activeList;

  ListTitle(this.activeList);

  @override
  Widget build(BuildContext context) {
    TaskModel state = Provider.of<TaskModel>(context, listen: true);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(60.0.w, 15.0.h, 60.0, 15.0.h),
          child: Text(
            '$activeList',
            style: TextStyle(
              fontSize: state.determineFontSize(context, 27.0),
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
