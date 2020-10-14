import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTitle extends StatelessWidget {
  final String activeList;

  ListTitle(this.activeList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var isTablet = width >= 600 ? true : false;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(60.0.h, 15.0, 60.0, 10.0.h),
          child: Text(
            '$activeList',
            style: TextStyle(
              fontSize: !isTablet ? 27.sp : 25.sp,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
