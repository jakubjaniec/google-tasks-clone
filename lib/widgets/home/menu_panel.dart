import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

final PanelController _pc = PanelController();

class MenuPanel extends StatelessWidget {
  final String activeList = 'Tasks';

  final BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

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
        maxHeight: size.height * 0.45,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Padding(
          padding: EdgeInsets.only(top: size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _UserSection(),
              Divider(color: Colors.grey[400]),
              _TaskListNames(),
              Divider(color: Colors.grey[400]),
              const _Option('Create new list', Icons.add),
              Divider(color: Colors.grey[400]),
              const _Option('Help and feedback', Icons.feedback)
            ],
          ),
        ),
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.07),
        child: Row(
          children: [
            CircleAvatar(
              radius: state.getAdaptiveTextSize(context, 19),
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: size.width * 0.035),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Doe',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: state.getAdaptiveTextSize(context, 15))),
                SizedBox(height: size.height * 0.006),
                Row(children: [
                  Text('johndoe@gmail.com',
                      style: TextStyle(
                          fontSize: state.getAdaptiveTextSize(context, 11))),
                  Icon(Icons.keyboard_arrow_down,
                      size: state.getAdaptiveTextSize(context, 14)),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TaskListNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: state.listTitles.map((list) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.19,
            vertical: size.height * 0.025,
          ),
          color: list == 'Tasks' ? Colors.lightBlue[50] : Colors.white,
          child: Text(
            '$list',
            style: TextStyle(
                color: list == 'Tasks' ? Colors.blue[800] : Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: state.getAdaptiveTextSize(context, 15)),
          ),
        );
      }).toList(),
    );
  }
}

class _Option extends StatelessWidget {
  final String optionText;
  final IconData optionIcon;

  const _Option(this.optionText, this.optionIcon);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Row(
          children: [
            Icon(optionIcon, size: state.getAdaptiveTextSize(context, 20)),
            SizedBox(width: size.width * 0.04),
            Text(optionText,
                style: TextStyle(
                    fontSize: state.getAdaptiveTextSize(context, 15),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
