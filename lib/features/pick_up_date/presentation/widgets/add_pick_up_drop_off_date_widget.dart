import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPickUpOrDropOffDateTextFieldWithTitle extends StatelessWidget {
  const AddPickUpOrDropOffDateTextFieldWithTitle({
    super.key,
    required this.textEditingController,
    required this.title,
    required this.hintText,
    this.isTime = true,
  });

  final TextEditingController textEditingController;
  final String title;
  final String hintText;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 10.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          width: double.infinity,
          height: 60.h,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFECECEC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.r)),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0xFFC9C9C9),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
              contentPadding: EdgeInsets.only(left: 20.w, top: 20.h),
              prefixIcon: Icon(
                isTime
                    ? Icons.timelapse_outlined
                    : Icons.calendar_today_outlined,
                color: const Color(0xFF000080),
                size: 24.r,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFECECEC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFECECEC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
