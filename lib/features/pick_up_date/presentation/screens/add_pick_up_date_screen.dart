import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/presentation/bloc/pick_up_date_bloc.dart';
import 'package:mobile/features/pick_up_date/presentation/widgets/add_pick_up_drop_off_date_widget.dart';

class TailorAddPickUpDateScreen extends StatefulWidget {
  const TailorAddPickUpDateScreen({super.key});

  @override
  State<TailorAddPickUpDateScreen> createState() =>
      _TailorAddPickUpDateScreenState();
}

class _TailorAddPickUpDateScreenState extends State<TailorAddPickUpDateScreen> {
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();

  void _validateAndSubmit() {
    final String date = dateEditingController.text.trim();
    final String fromTime = fromTimeController.text.trim();
    final String toTime = toTimeController.text.trim();

    if (date.isEmpty || fromTime.isEmpty || toTime.isEmpty) {
      EasyLoading.showError('Please fill all fields',
          duration: const Duration(seconds: 2), dismissOnTap: true);
      return;
    }

    if (!isValidDateFormat(date)) {
      EasyLoading.showError('Invalid date formate: Please enter a valid date',
          duration: const Duration(seconds: 2), dismissOnTap: true);
      return;
    }
    if (!isValidTimeFormat(fromTime)) {
      EasyLoading.showError(
          'Invalid from time formate: Please enter a valid time format',
          duration: const Duration(seconds: 2),
          dismissOnTap: true);

      return;
    }
    if (!isValidTimeFormat(toTime)) {
      EasyLoading.showError(
          'Invalid to time formate: Please enter a valid time format',
          duration: const Duration(seconds: 2),
          dismissOnTap: true);
      return;
    }

    final DateTime fromDateTime = DateTime.parse("$date $fromTime");
    final DateTime toDateTime = DateTime.parse("$date $toTime");

    if (!isValidTimeDifference(fromDateTime, toDateTime)) {
      EasyLoading.showError(
          'Incorrect pick up date interval: The difference between the from and to time should be exactly 2 hours long',
          duration: const Duration(seconds: 4),
          dismissOnTap: true);
      return;
    }

    final String pickUpDateTimeRequest = "$date $fromTime,$date $toTime";

    final CreatePickUpDateEntity createPickUpDateEntity =
        CreatePickUpDateEntity(pickUpDateTime: pickUpDateTimeRequest);

    BlocProvider.of<PickUpDateBloc>(context).add(
        CreatePickUpDateEvent(createPickUpDateEntity: createPickUpDateEntity));
  }

  bool isValidDateFormat(String input) {
    final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegex.hasMatch(input);
  }

  bool isValidTimeFormat(String input) {
    final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$');
    return timeRegex.hasMatch(input);
  }

  bool isValidTimeDifference(DateTime from, DateTime to) {
    return to.difference(from) == const Duration(hours: 2);
  }

  void clearFields() {
    dateEditingController.clear();
    fromTimeController.clear();
    toTimeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/${AppRouteNames.tailorHome}');
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
          "Add Pick Up Date",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.0.h),
          child: Column(children: [
            // Padding(
            //   padding: EdgeInsets.only(top: 30.h, left: 20.w, bottom: 10.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Add Pick Up Date",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 24.sp,
            //           fontFamily: 'Poppins',
            //           fontWeight: FontWeight.w500,
            //           height: 0,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            AddPickUpOrDropOffDateTextFieldWithTitle(
              textEditingController: dateEditingController,
              hintText: '2023-11-10',
              title: 'Date',
              isTime: false,
            ),
            AddPickUpOrDropOffDateTextFieldWithTitle(
              textEditingController: fromTimeController,
              title: 'From',
              hintText: '10:00:00',
            ),
            AddPickUpOrDropOffDateTextFieldWithTitle(
              textEditingController: toTimeController,
              title: 'To',
              hintText: '12:00:00',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0.h),
              child: BlocConsumer<PickUpDateBloc, PickUpDateState>(
                listener: (context, state) {
                  if (state is CreatePickUpDateSuccessState) {
                    EasyLoading.showSuccess('Pick Up Date Added successfully',
                        duration: const Duration(seconds: 2),
                        dismissOnTap: true);

                    Future.delayed(const Duration(seconds: 2), () {
                      context.go('/${AppRouteNames.tailorHome}');
                    });
                  } else if (state is PickUpDateErrorState) {
                    EasyLoading.showError(state.message,
                        duration: const Duration(seconds: 2),
                        dismissOnTap: true);
                  }
                },
                builder: (context, state) {
                  if (state is PickUpDateLoadingState) {
                    return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: Size(300.w, 70.h),
                        backgroundColor: const Color(0xFF000080),
                      ),
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 15,
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        _validateAndSubmit();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: Size(300.w, 70.h),
                        backgroundColor: const Color(0xFF000080),
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 25.h,
                          color: Colors.white,
                          fontFamily: "Roboto-Medium",
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
