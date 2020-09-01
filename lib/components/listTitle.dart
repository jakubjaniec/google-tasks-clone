import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  final String activeList;

  ListTitle(this.activeList);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 10.0),
          child: Text(
            '$activeList',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
