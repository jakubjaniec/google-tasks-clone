import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/models.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        actions: [
          IconButton(
            onPressed: () => state.markDone(args['index'], context, 'details'),
            icon: task['done'] ? Icon(Icons.undo) : Icon(Icons.check),
          ),
          IconButton(
            onPressed: () => state.deleteTask(context, args['index']),
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('Tasks',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[800])),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 25,
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
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text("${task['title']}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 26,
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
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
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
        padding: EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            type == 'details'
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        onChanged: (value) => state.addDetails(index, value),
                        style: TextStyle(color: Colors.black),
                        initialValue: details != '' ? '$details' : null,
                        decoration: InputDecoration(
                            hintText: '$label',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.grey[700])),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      textColor: Colors.grey[700],
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      onPressed: () {},
                      child: Text('$label',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ),
          ],
        ));
  }
}
