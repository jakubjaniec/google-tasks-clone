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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Column(
        children: [
          Expanded(
            child: InkWell(onTap: () => Navigator.pop(context)),
          ),
          SlidingUpPanel(
            controller: _pc,
            minHeight: MediaQuery.of(context).size.height / 5.5,
            maxHeight: MediaQuery.of(context).size.height / 5.5,
            padding: EdgeInsets.only(top: 10.0, left: 15.0),
            panel: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
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
                          Icon(Icons.menu, color: Colors.blue[600]),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.calendar_today, color: Colors.blue[600])
                        ]),
                        FlatButton(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            textColor: Colors.blue[600],
                            disabledTextColor: Colors.grey,
                            onPressed:
                                inputValue != '' ? widget.addTask : null),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
