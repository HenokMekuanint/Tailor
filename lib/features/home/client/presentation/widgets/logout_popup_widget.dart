import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LogoutPopupWidget extends StatefulWidget {
  const LogoutPopupWidget({super.key});

  @override
  State<LogoutPopupWidget> createState() => _LogoutPopupWidgetState();
}

class _LogoutPopupWidgetState extends State<LogoutPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 80.w),
              child: const Text(
                "Logout",
                style: TextStyle(fontFamily: "Roboto-Medium"),
              )),
          GestureDetector(
            onTap: () {
              context.pop(false);
            },
            child: SvgPicture.asset("assets/images/popupcancel.svg"),
          )
        ],
      ),
      content: SizedBox(
        height: 150.h,
        width: 250.w,
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(left: 20.w),
              child: const Text(
                """Are you sure you want to 
                logout? """,
                style: TextStyle(height: 2, fontFamily: "Roboto-Regular"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110.w,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Inner background color
                        side: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF000080)), // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25.0), // Border radius
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFF000080)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110.w,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Inner background color
                        side: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF000080)), // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Border radius
                        ),
                      ),
                      child: const Text(
                        ' Yes ',
                        style: TextStyle(color: Color(0xFF000080)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
