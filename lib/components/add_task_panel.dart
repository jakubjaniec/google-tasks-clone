import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:Google_Task_Clone/task_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskPanel extends StatelessWidget {
  final PanelController _pc = PanelController();

  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5.sp), topRight: Radius.circular(7.5.sp));

  void openPanel() {
    Timer(Duration(milliseconds: 1), () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    openPanel();

    TaskModel state = Provider.of<TaskModel>(context, listen: true);
    double width = MediaQuery.of(context).size.width;

    bool isTablet = width >= 600 ? true : false;

    double determinePanelPadding() {
      double padding = 5.0.h;

      if (width >= 400 && width < 600)
        padding = 7.5.h;
      else if (width >= 600 && width < 800)
        padding = 10.0.h;
      else if (width >= 800) padding = 12.5.h;

      return padding;
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: 120.h,
        padding: EdgeInsets.only(left: 10.0.w, right: 5.0.w),
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Container(
          padding: EdgeInsets.only(top: determinePanelPadding(), bottom: 5.0.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 12.0),
                child: TextField(
                  onChanged: (value) => state.handleInputValueChange(value),
                  maxLines: null,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: state.determineFontSize(context, 15.0),
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'New Task'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.sort),
                          iconSize: state.determineFontSize(context, 25.0),
                          color: Colors.blue[600]),
                      IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.only(left: isTablet ? 7.5.h : 0),
                          icon: Icon(Icons.event_available),
                          iconSize: state.determineFontSize(context, 25.0),
                          color: Colors.blue[600])
                    ],
                  ),
                  FlatButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: state.determineFontSize(context, 17.0)),
                      ),
                      textColor: Colors.blue[600],
                      disabledTextColor: Colors.grey[400],
                      onPressed: state.taskTitle != ''
                          ? () => state.addTask(context)
                          : null),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
