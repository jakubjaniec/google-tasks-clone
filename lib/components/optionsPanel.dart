import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:Google_Task_Clone/models.dart';
import 'package:provider/provider.dart';

class OptionsPanel extends StatelessWidget {
  final PanelController _pc = PanelController();

  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  final TextStyle mainText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  final TextStyle subText = TextStyle(fontSize: 11, color: Colors.grey);

  void openPanel() async {
    Timer(Duration(milliseconds: 1), () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TaskModel>(context, listen: true);
    openPanel();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height / 2,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        color: Colors.white,
        panel: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sort by', style: mainText),
                      SizedBox(height: 2.5),
                      Text('My order', style: subText)
                    ],
                  )),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text('Rename list', style: mainText)),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Text('Delete list', style: mainText)),
                    InkWell(
                      onTap: () => state.deleteDoneTasks(context),
                      child: Container(
                          child: Text('Delete all completed tasks',
                              style: mainText)),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Copy reminders to the tasks list',
                      style: mainText)),
              Divider(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Theme', style: mainText),
                      SizedBox(height: 2.5),
                      Text('Light', style: subText)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
