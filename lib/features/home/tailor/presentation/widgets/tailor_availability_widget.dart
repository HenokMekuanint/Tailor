import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';

class AvailabilityWidget extends StatefulWidget {
  const AvailabilityWidget({
    Key? key,
    required this.dropOffDateEntity,
  }) : super(key: key);

  final DropOffDateEntity dropOffDateEntity;

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> dateTimeComponents =
        widget.dropOffDateEntity.dropOffDateTime.split(',');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 120.w,
          height: 80.h,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFECECEC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(right: 5),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: const Color(0XFF000080),
              //   ),
              //   height: double.infinity,
              //   width: 30.w,
              //   child: Center(
              //     child: Icon(
              //       Icons.calendar_month,
              //       color: Colors.white,
              //       size: 20.r,
              //     ),
              //   ),
              // ),
              Text(
                dateTimeComponents[0].split(' ')[0],
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 110.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFECECEC),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(right: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: const Color(0XFF000080),
              //   ),
              //   height: double.infinity,
              //   width: 30.w,
              //   child: Center(
              //     child: Icon(
              //       Icons.timer,
              //       color: Colors.white,
              //       size: 20.r,
              //     ),
              //   ),
              // ),
              Text(dateTimeComponents[0].split(' ')[1],
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 110.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFECECEC),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(right: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: const Color(0XFF000080),
              //   ),
              //   height: double.infinity,
              //   width: 30.w,
              //   child: Center(
              //     child: Icon(
              //       Icons.timer,
              //       color: Colors.white,
              //       size: 20.r,
              //     ),
              //   ),
              // ),
              Text(dateTimeComponents[1].split(' ')[1],
                  style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(bottom: 30.h),
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.delete,
        //       size: 30.r,
        //       color: Colors.red,
        //     ),
        //   ),
        // )
      ],
    );
  }
}

class PickUpDateAvailabilityWidget extends StatefulWidget {
  const PickUpDateAvailabilityWidget({
    Key? key,
    required this.pickUpDateEntity,
  }) : super(key: key);

  final PickUpDateEntity pickUpDateEntity;

  @override
  State<PickUpDateAvailabilityWidget> createState() =>
      _PickUpDateAvailabilityWidgetState();
}

class _PickUpDateAvailabilityWidgetState
    extends State<PickUpDateAvailabilityWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> dateTimeComponents =
        widget.pickUpDateEntity.pickUpDateTime.split(',');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 120.w,
          height: 80.h,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFECECEC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateTimeComponents[0].split(' ')[0],
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 110.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFECECEC),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateTimeComponents[0].split(' ')[1],
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 30.h,
            left: 10.w,
          ),
          width: 110.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFECECEC),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateTimeComponents[1].split(' ')[1],
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(bottom: 30.h),
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.delete,
        //       size: 30.r,
        //       color: Colors.red,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
