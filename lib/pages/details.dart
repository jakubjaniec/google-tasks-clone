import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    Map task = args['task'];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          iconSize: 22.h,
        ),
        actions: [
          IconButton(
            onPressed: () => state.markDone(args['index'], context, 'details'),
            icon: task['done'] ? Icon(Icons.undo) : Icon(Icons.check),
            iconSize: 22.h,
          ),
          IconButton(
            onPressed: () => state.deleteTask(context, args['index']),
            icon: Icon(Icons.delete),
            iconSize: 22.h,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('Tasks',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[800])),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24.h,
                color: Colors.blue[800],
              )
            ]),
            task['done']
                ? DoneTaskDetails(task)
                : ActiveTaskDetails(task, args['index']),
          ],
        ),
      ),
    );
  }
}

class DoneTaskDetails extends StatelessWidget {
  final Map task;

  DoneTaskDetails(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0.h),
      child: Text("${task['title']}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              decoration: TextDecoration.lineThrough)),
    );
  }
}

class ActiveTaskDetails extends StatelessWidget {
  final Map task;
  final int index;

  ActiveTaskDetails(this.task, this.index);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            onChanged: (value) => state.editTaskTitle(index, value),
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            initialValue: task['title'],
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button(
                'Add details', Icons.sort, 'details', index, task['details']),
            Button('Add date/hour', Icons.event_available, 'date'),
            Button('Add subtasks', Icons.subdirectory_arrow_right, 'subtasks'),
          ],
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final IconData icon;
  final String type;
  final int index;
  final String details;

  Button(this.label, this.icon, this.type, [this.index, this.details]);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 7.0.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 22.h),
            type == 'details'
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0.w),
                      child: TextFormField(
                        onChanged: (value) => state.addDetails(index, value),
                        style: TextStyle(color: Colors.black),
                        initialValue: details != '' ? '$details' : null,
                        decoration: InputDecoration(
                            hintText: '$label',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Colors.grey[700])),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: FlatButton(
                      textColor: Colors.grey[700],
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      onPressed: () {},
                      child: Text('$label',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500)),
                    ),
                  ),
          ],
        ));
  }
}
