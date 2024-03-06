import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TailorNotificationScreen extends StatelessWidget {
  const TailorNotificationScreen({super.key, required this.notice});

  final Map<String, String> notice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              context.pop();
            },
          ),
          title: Text('Notification Detail'),
        ),
        backgroundColor: Color(0xff000080),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50.h),
          child: Column(
            children: [
              Text(
                '${notice['title']}',
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                softWrap: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  '${notice['body']}',
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ));
  }
}
