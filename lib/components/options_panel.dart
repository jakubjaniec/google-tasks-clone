import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:Google_Task_Clone/task_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsPanel extends StatelessWidget {
  final PanelController _pc = PanelController();

  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  final TextStyle mainText =
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500);
  final TextStyle subText = TextStyle(fontSize: 10.sp, color: Colors.grey);

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
      backgroundColor: Colors.black.withOpacity(0),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: 295.h,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        borderRadius: radius,
        color: Colors.white,
        panel: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
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
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text('Rename list', style: mainText)),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30.h),
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
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text('Copy reminders to the tasks list',
                      style: mainText)),
              Divider(),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
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
