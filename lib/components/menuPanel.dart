import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MenuPanel extends StatefulWidget {
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
      body: Column(
        children: [
          Expanded(
            child: InkWell(onTap: () => Navigator.pop(context)),
          ),
          SlidingUpPanel(
            controller: _pc,
            defaultPanelState: PanelState.OPEN,
            onPanelClosed: () => Navigator.maybePop(context),
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            borderRadius: radius,
            panel: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
