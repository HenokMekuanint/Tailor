// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/utils/date_converter.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';

class TailorOrderDetailPage extends StatefulWidget {
  const TailorOrderDetailPage({super.key, required this.order});

  final OrderEntity order;

  @override
  State<TailorOrderDetailPage> createState() => _TailorOrderDetailPageState();
}

class _TailorOrderDetailPageState extends State<TailorOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.white,
          ),
        ),
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Order Detail",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 10.w,
              //         vertical: 10.h,
              //       ),
              //       child: IconButton(
              //         onPressed: () {
              //           context.pop();
              //         },
              //         icon: Icon(
              //           Icons.keyboard_arrow_left_rounded,
              //           size: 40.h,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       child: Text(
              //         "Order Detail",
              //         style: TextStyle(
              //           fontSize: 28.sp,
              //           fontFamily: "Roboto-Medium",
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                ),
                child: Text(
                  "User Detail",
                  style: TextStyle(
                    fontFamily: "Roboto-Medium",
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Container(
                width: 350.w, // Set the desired width
                height: 160.h,
                margin: EdgeInsets.only(
                  bottom: 10.h,
                  left: 20.w,
                  top: 20.h,
                ),
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
                  color: const Color(0xff0000080),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              "Address",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 18.sp,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.name,
                              // softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              widget.order.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              widget.order.address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                ),
                child: Text(
                  "Drop off Date",
                  style: TextStyle(
                    fontFamily: "Roboto-Medium",
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 45.w,
                  top: 10.h,
                ),
                child: Row(
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
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  "Pick Up Date",
                  style: TextStyle(
                    fontFamily: "Roboto-Medium",
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 45.w,
                  top: 10.h,
                ),
                child: Row(
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
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    top: 20.h,
                  ),
                  child: Text(
                    "Status",
                    style: TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 18.sp,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  left: 45.w,
                  top: 10.h,
                ),
                child: Text(
                  widget.order.status,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    top: 20.h,
                  ),
                  child: Text(
                    "Payment Status",
                    style: TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 18.sp,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  left: 45.w,
                  top: 10.h,
                ),
                child: Text(
                  widget.order.paymentStatus,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Container(
                width: 350.w, // Set the desired width
                height: 250.h,
                margin: EdgeInsets.only(
                  bottom: 10.h,
                  left: 20.w,
                  top: 20.h,
                  right: 20.w,
                ),
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
                  color: const Color(0xff0000080),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto-Medium",
                            fontSize: 20.sp,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              widget.order.serviceName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              "${widget.order.price}\$",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto-Medium",
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          widget.order.serviceDescription,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
