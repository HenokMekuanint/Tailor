import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';

class popupWidget extends StatefulWidget {
  const popupWidget({super.key, required this.service});

  final Services service;

  @override
  State<popupWidget> createState() => _popupWidgetState();
}

class _popupWidgetState extends State<popupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Service Details",
                style: TextStyle(fontFamily: "Roboto-Medium"),
              )),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset("assets/images/popupcancel.svg"),
          )
        ],
      ),
      content: Container(
        height: 170.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Service Name",
                    style: TextStyle(fontFamily: "Roboto-Medium")),
                Text(widget.service.name)
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: const Text("Description",
                  style: TextStyle(fontFamily: "Roboto-Medium")),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w),
              child: Text(
                widget.service.description,
                softWrap: true,
                style: const TextStyle(fontFamily: "Roboto-Regular"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Price",
                      style: TextStyle(fontFamily: "Roboto-Medium")),
                  Text("\$${widget.service.price}")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
