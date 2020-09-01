import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    Map task = args['task'];
    Function markDone = args['markDone'];
    Function deleteTask = args['deleteTask'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        actions: [
          IconButton(
            onPressed: () => markDone(args['index'], 'details'),
            icon: task['done'] ? Icon(Icons.undo) : Icon(Icons.check),
          ),
          IconButton(
            onPressed: () => deleteTask(args['index'], 'details'),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text("${task['title']}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      decoration:
                          task['done'] ? TextDecoration.lineThrough : null)),
            ),
            !task['done']
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Button('Add details', Icon(Icons.sort)),
                      Button('Add date/hour', Icon(Icons.event_available)),
                      Button(
                          'Add subtasks', Icon(Icons.subdirectory_arrow_right)),
                    ],
                  )
                : Container(),
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
