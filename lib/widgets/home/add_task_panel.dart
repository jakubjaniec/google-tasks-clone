import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

final PanelController _pc = PanelController();

class AddTaskPanel extends StatelessWidget {
  final BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(7.5),
    topRight: Radius.circular(7.5),
  );

  void openPanel() {
    Future.delayed(Duration.zero, () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    openPanel();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: SlidingUpPanel(
        controller: _pc,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: size.height * 0.16,
        padding: EdgeInsets.only(
          left: size.width * 0.03,
        ),
        backdropEnabled: true,
        borderRadius: radius,
        panel: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TaskTitleInput(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Icons(),
                  _SaveTaskButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskTitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.02),
      child: TextField(
        onChanged: (value) => state.handleInputValueChange(value),
        maxLines: null,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: state.getAdaptiveTextSize(context, 15.0),
        ),
        // autofocus: false,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: 'New Task'),
      ),
    );
  }
}

class _Icons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600 ?? false;

    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
            iconSize: state.getAdaptiveTextSize(context, 25.0),
            color: Colors.blue[600]),
        SizedBox(width: size.width * 0.01),
        IconButton(
            onPressed: () {},
            padding: EdgeInsets.only(left: isTablet ? size.width * 0.05 : 0),
            icon: const Icon(Icons.event_available),
            iconSize: state.getAdaptiveTextSize(context, 25.0),
            color: Colors.blue[600])
      ],
    );
  }
}

class _SaveTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();

    return FlatButton(
      textColor: Colors.blue[600],
      disabledTextColor: Colors.grey[400],
      onPressed: state.taskTitle != '' ? () => state.addTask(context) : null,
      child: Text(
        'Save',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: state.getAdaptiveTextSize(context, 17.0)),
      ),
    );
  }
}
