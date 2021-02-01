import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Google_Task_Clone/providers/task_provider.dart';

class Option extends StatelessWidget {
  final String label;
  final IconData icon;
  final String type;
  final dynamic index;
  final dynamic details;

  const Option(this.label, this.icon, this.type, [this.index, this.details]);

  @override
  Widget build(BuildContext context) {
    final TaskProvider state = context.watch<TaskProvider>();
    final Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Row(
          children: [
            Icon(icon,
                color: Colors.grey[700],
                size: state.getAdaptiveTextSize(context, 22)),
            if (type == 'details')
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.04),
                  child: TextFormField(
                    onChanged: (value) => state.addDetails(index as int, value),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: state.getAdaptiveTextSize(context, 17),
                        fontWeight: FontWeight.w500),
                    initialValue: details != '' ? '$details' : null,
                    decoration: InputDecoration(
                        hintText: label,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: state.getAdaptiveTextSize(context, 17),
                            color: Colors.grey[700])),
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.01),
                child: FlatButton(
                  textColor: Colors.grey[700],
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  onPressed: () {},
                  child: Text(label,
                      style: TextStyle(
                          fontSize: state.getAdaptiveTextSize(context, 17),
                          fontWeight: FontWeight.w500)),
                ),
              ),
          ],
        ));
  }
}
