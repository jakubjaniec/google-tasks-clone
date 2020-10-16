import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/task_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPanel extends StatelessWidget {
  final String activeList = 'Tasks';

  final PanelController _pc = PanelController();
  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  void openPanel() {
    Timer(Duration(milliseconds: 1), () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    openPanel();
    TaskModel state = Provider.of<TaskModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height / 2,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0.h, bottom: 12.0.h, top: 20.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: state.determineFontSize(context, 18),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 10.0.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: state.determineFontSize(context, 15))),
                      SizedBox(height: 5.0),
                      Row(children: [
                        Text(
                          'johndoe@gmail.com',
                          style: TextStyle(
                              fontSize: state.determineFontSize(context, 11.5)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16.sp,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 50.h, vertical: 12.5.h),
                    color:
                        list == 'Tasks' ? Colors.lightBlue[50] : Colors.white,
                    child: Text(
                      list,
                      style: TextStyle(
                          color:
                              list == 'Tasks' ? Colors.blue[800] : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: state.determineFontSize(context, 15)),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: state.determineFontSize(context, 20)),
                    SizedBox(width: 12.0.w),
                    Text('Create new list',
                        style: TextStyle(
                            fontSize: state.determineFontSize(context, 15),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey[400]),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                  child: Row(
                    children: [
                      Icon(Icons.feedback,
                          size: state.determineFontSize(context, 19)),
                      SizedBox(width: 12.0.w),
                      Text('Help and feedback',
                          style: TextStyle(
                              fontSize: state.determineFontSize(context, 15),
                              fontWeight: FontWeight.w500)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
