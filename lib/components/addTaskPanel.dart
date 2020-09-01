import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddTaskPanel extends StatefulWidget {
  final Function handleInputValue;
  final Function addTask;

  AddTaskPanel(this.handleInputValue, this.addTask);

  @override
  _AddTaskPanelState createState() => _AddTaskPanelState();
}

class _AddTaskPanelState extends State<AddTaskPanel> {
  String inputValue = '';

  PanelController _pc = PanelController();

  BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.OPEN,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height / 5,
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(left: 12.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputValue = value;
                    });
                    widget.handleInputValue(value);
                  },
                  maxLines: null,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'New Task'),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.sort),
                          color: Colors.blue[600]),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(Icons.event_available),
                          color: Colors.blue[600])
                    ]),
                    FlatButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        textColor: Colors.blue[600],
                        disabledTextColor: Colors.grey[400],
                        onPressed: inputValue != '' ? widget.addTask : null),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
