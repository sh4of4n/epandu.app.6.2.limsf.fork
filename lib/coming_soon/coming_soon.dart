import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Coming Soon!',
          style: TextStyle(
            fontSize: 90.sp,
          ),
        ),
      ),
    );
  }
}
