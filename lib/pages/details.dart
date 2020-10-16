import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(320.0, 569.0));

    final Map args = ModalRoute.of(context).settings.arguments as Map;
    Map task = args['task'];

    TaskModel state = Provider.of<TaskModel>(context, listen: true);
    double width = MediaQuery.of(context).size.width;

    double determinePadding() {
      double padding = 0.0;

      if (width >= 400 && width < 600)
        padding = 7.5.h;
      else if (width >= 600 && width < 800)
        padding = 12.5.h;
      else if (width >= 800) padding = 15.0.h;

      return padding;
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        leading: Padding(
          padding: EdgeInsets.only(left: determinePadding()),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            iconSize: state.determineFontSize(context, 22),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => state.markDone(args['index'], context, 'details'),
            icon: task['done'] ? Icon(Icons.undo) : Icon(Icons.check),
            iconSize: state.determineFontSize(context, 22),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: determinePadding(), left: determinePadding()),
            child: IconButton(
              onPressed: () => state.deleteTask(context, args['index']),
              icon: Icon(Icons.delete),
              iconSize: state.determineFontSize(context, 22),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: determinePadding()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('Tasks',
                  style: TextStyle(
                      fontSize: state.determineFontSize(context, 14),
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[800])),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down),
                iconSize: state.determineFontSize(context, 24),
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
    TaskModel state = Provider.of<TaskModel>(context, listen: true);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0.h),
      child: Text("${task['title']}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: state.determineFontSize(context, 24),
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
    TaskModel state = Provider.of<TaskModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            onChanged: (value) => state.editTaskTitle(index, value),
            style: TextStyle(
                fontSize: state.determineFontSize(context, 24),
                fontWeight: FontWeight.w500),
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
    var width = MediaQuery.of(context).size.width;

    double determinePadding() {
      var padding = 5.0;

      if (width >= 400 && width < 600)
        padding = 12.5.h;
      else if (width >= 600 && width < 800)
        padding = 17.5.h;
      else if (width >= 800) padding = 20.0.h;

      return padding;
    }

    return Padding(
        padding: EdgeInsets.symmetric(vertical: determinePadding()),
        child: Row(
          children: [
            Icon(icon,
                color: Colors.grey[700],
                size: state.determineFontSize(context, 22)),
            type == 'details'
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0.w),
                      child: TextFormField(
                        onChanged: (value) => state.addDetails(index, value),
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: state.determineFontSize(context, 17),
                            fontWeight: FontWeight.w500),
                        initialValue: details != '' ? '$details' : null,
                        decoration: InputDecoration(
                            hintText: '$label',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: state.determineFontSize(context, 17),
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
                              fontSize: state.determineFontSize(context, 17),
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
          ],
        ));
  }
}
