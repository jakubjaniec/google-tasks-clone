import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OptionsPanel extends StatelessWidget {
  final PanelController _pc = PanelController();
  final Function deleteDoneTasks;

  OptionsPanel(this.deleteDoneTasks);

  final BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

  final TextStyle mainText =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  final TextStyle subText = TextStyle(fontSize: 12, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SlidingUpPanel(
        controller: _pc,
        defaultPanelState: PanelState.OPEN,
        onPanelClosed: () => Navigator.maybePop(context),
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height / 2,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        borderRadius: radius,
        panel: Container(
          color: Colors.white,
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
                    Container(
                        child:
                            Text('Change name of the list', style: mainText)),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Text('Delete list', style: mainText)),
                    InkWell(
                      onTap: deleteDoneTasks,
                      child: Container(
                          child:
                              Text('Delete all done tasks', style: mainText)),
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
