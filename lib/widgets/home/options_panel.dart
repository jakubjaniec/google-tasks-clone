import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

final PanelController _pc = PanelController();

class OptionsPanel extends StatelessWidget {
  final BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  void openPanel() {
    Future.delayed(Duration.zero, () {
      _pc.open();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;
    openPanel();

    final TextStyle mainText = TextStyle(
      fontSize: state.getAdaptiveTextSize(context, 13),
      fontWeight: FontWeight.w500,
    );
    final TextStyle subText = TextStyle(
      fontSize: state.getAdaptiveTextSize(context, 11),
      color: Colors.grey,
    );

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: SlidingUpPanel(
        controller: _pc,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: size.height / 1.9,
        backdropEnabled: true,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        borderRadius: radius,
        panel: Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.027),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SortByOption(mainText, subText),
              const Divider(),
              _ListOptions(mainText, subText),
              const Divider(),
              _CopyRemindersOption(mainText),
              const Divider(),
              _ThemeOption(mainText, subText),
            ],
          ),
        ),
      ),
    );
  }
}

class _SortByOption extends StatelessWidget {
  final TextStyle mainText;
  final TextStyle subText;

  const _SortByOption(this.mainText, this.subText);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sort by', style: mainText),
        SizedBox(height: size.height * 0.004),
        Text('My order', style: subText)
      ],
    );
  }
}

class _ListOptions extends StatelessWidget {
  final TextStyle mainText;
  final TextStyle subText;

  const _ListOptions(this.mainText, this.subText);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rename list', style: mainText),
          Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.05),
              child: Text('Delete list', style: mainText)),
          InkWell(
            onTap: () => state.deleteDoneTasks(context),
            child: Text('Delete all completed tasks', style: mainText),
          ),
        ],
      ),
    );
  }
}

class _CopyRemindersOption extends StatelessWidget {
  final TextStyle mainText;

  const _CopyRemindersOption(this.mainText);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
        child: Text('Copy reminders to the tasks list', style: mainText));
  }
}

class _ThemeOption extends StatelessWidget {
  final TextStyle mainText;
  final TextStyle subText;

  const _ThemeOption(this.mainText, this.subText);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme', style: mainText),
            SizedBox(height: size.height * 0.01),
            Text('Light', style: subText)
          ],
        ));
  }
}
