import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/models.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MenuPanel extends StatelessWidget {
  final String activeList;

  MenuPanel(this.activeList);

  final PanelController _pc = PanelController();
  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  void openPanel(context, state) {
    var height = MediaQuery.of(context).size.height;
    state.maxHeightPicker(height);
    Timer(Duration(milliseconds: 1), () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    openPanel(context, state);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: state.maxHeight,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 12.0, top: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0)),
                      SizedBox(height: 5.0),
                      Row(children: [
                        Text('johndoe@gmail.com',
                            style: TextStyle(fontSize: 12.0)),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                        ),
                      ]),
                    ],
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey[400]),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.listTitles.map((list) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    color: list == activeList
                        ? Colors.lightBlue[50]
                        : Colors.white,
                    child: Text(
                      list,
                      style: TextStyle(
                          color: list == activeList
                              ? Colors.blue[800]
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 10.0),
                    Text('Create new list',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Icon(Icons.feedback, size: 20),
                      SizedBox(width: 10.0),
                      Text('Help and opinions',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
