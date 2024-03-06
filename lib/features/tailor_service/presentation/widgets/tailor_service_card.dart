import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';

class TailorServiceCard extends StatefulWidget {
  final ServiceEntity service;
  const TailorServiceCard({super.key, required this.service});

  @override
  State<TailorServiceCard> createState() => _TailorServiceCardState();
}

class _TailorServiceCardState extends State<TailorServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, bottom: 15.h, right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0,
            spreadRadius: 0.3,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.service.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto-Medium",
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              widget.service.description,
              style: const TextStyle(fontSize: 10),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price"),
                Text("\$ ${widget.service.price}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
