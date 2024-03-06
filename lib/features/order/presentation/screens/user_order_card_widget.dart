import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/utils/date_converter.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';

class orderCard extends StatefulWidget {
  const orderCard({super.key, required this.order});

  final OrderEntity order;

  @override
  State<orderCard> createState() => _orderCardState();
}

class _orderCardState extends State<orderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w, // Set the desired width
      height: 220.h,
      margin: EdgeInsets.only(bottom: 10.h, left: 20.w, top: 20.h, right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Card(
        color: const Color(0XFF0000080),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.order.name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-Medium",
                  fontSize: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Service: ${widget.order.serviceName}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto-Medium",
                  fontSize: 18.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Drop of Date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        child: SvgPicture.asset(
                          "assets/images/calendar.svg",
                        ),
                      ),
                      Text(
                        formatDateTimeRange(
                          widget.order.dropOffDate[0],
                          widget.order.dropOffDate[1],
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pick up Date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        child: SvgPicture.asset(
                          "assets/images/calendar.svg",
                        ),
                      ),
                      Text(
                        formatDateTimeRange(
                          widget.order.pickUpDate[0],
                          widget.order.pickUpDate[1],
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ), // You can adjust the elevation as needed
      ),
    );
  }
}
