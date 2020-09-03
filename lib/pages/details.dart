import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/models.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    Map task = args['task'];
    var state = Provider.of<TaskModel>(context, listen: true);
    return Scaffold(
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
            onPressed: () => state.deleteTask(
              args['index'],
            ),
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
            task['done'] ? DoneTaskDetails(task) : ActiveTaskDetails(task),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String btnText;
  final Icon icon;

  Button(this.btnText, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: FlatButton.icon(
        textColor: Colors.grey[700],
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: icon,
        label: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            '$btnText',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
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

  ActiveTaskDetails(this.task);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text("${task['title']}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 26,
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button('Add details', Icon(Icons.sort)),
            Button('Add date/hour', Icon(Icons.event_available)),
            Button('Add subtasks', Icon(Icons.subdirectory_arrow_right)),
          ],
        )
      ],
    );
  }
}
