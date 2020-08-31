import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function openMenu;
  final Function openOptions;

  BottomBar(this.openMenu, this.openOptions);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 26,
              color: Colors.grey[600],
              icon: Icon(Icons.menu),
              onPressed: openMenu,
            ),
            IconButton(
              iconSize: 26,
              color: Colors.grey[600],
              icon: Icon(Icons.more_vert),
              onPressed: openOptions,
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskPanelButton extends StatelessWidget {
  final Function openPanel;

  AddTaskPanelButton(this.openPanel);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: openPanel,
      child: Icon(
        Icons.add,
        color: Colors.blue[600],
        size: 35,
      ),
    );
  }
}
