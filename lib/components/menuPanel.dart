import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MenuPanel extends StatefulWidget {
  final listTitles = ['Tasks', 'Shopping'];

  final String activeList;

  MenuPanel(this.activeList);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  PanelController _pc = PanelController();

  BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5));

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
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.listTitles.map((list) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    color: list == widget.activeList
                        ? Colors.lightBlue[50]
                        : Colors.white,
                    child: Text(
                      list,
                      style: TextStyle(
                          color: list == widget.activeList
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
