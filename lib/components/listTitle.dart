import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(60.0, 13.0, 60.0, 10.0),
          child: Text(
            'Tasks',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
