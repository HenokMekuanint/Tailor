import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';

import 'package:mobile/features/home/client/presentation/widgets/popup_page.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailor_detail_request.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/user_nearest_tailors_bloc.dart';

class UserTailorDetailsScreen extends StatefulWidget {
  const UserTailorDetailsScreen(
      {super.key, required this.tailorId, this.distance = 2000});

  final int tailorId;
  final double distance;

  @override
  State<UserTailorDetailsScreen> createState() =>
      _UserTailorDetailsScreenState();
}

class _UserTailorDetailsScreenState extends State<UserTailorDetailsScreen> {
  List<String> fields = ["Phone number", "Email", "Distance", "Address"];
  List<String> datas = [
    "+123456789",
    "moisagloria@email.com",
    "1KM away",
    "5th Avenue, NewYork"
  ];

  // List<String> services = [
  //   "Service 1",
  //   "Service 2",
  //   "Service 3",
  //   "Service 4",
  //   "Service 5",
  //   "Service"
  // ];

  @override
  void initState() {
    final GetNearestTailorRequestModel getNearestTailorRequestModel =
        GetNearestTailorRequestModel(id: widget.tailorId);
    BlocProvider.of<UserNearestTailorsBloc>(context).add(
        GetNearestTailorDetailEvent(
            getNearestTailorRequestModel: getNearestTailorRequestModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.goNamed(AppRouteNames.userMainPage),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Tailor Details",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: const EdgeInsets.all(10),
                //   child: InkWell(
                //     onTap: () {
                //       context.go('/${AppRouteNames.userMainPage}');
                //     },
                //     child: const Icon(
                //       Icons.arrow_back,
                //     ),
                //   ),
                // ),
                BlocConsumer<UserNearestTailorsBloc, UserNearestTailorsState>(
                  listener: (context, state) {
                    if (state is UserNearestTailorDetailErrorState) {
                      EasyLoading.showError(state.message);
                    }
                  },
                  builder: (context, state) {
                    debugPrint(" ....tailor detail state is..... $state");
                    if (state is UserNearestTailorDetailLoadingState ||
                        state is UserNearestTailorsInitialState) {
                      return Padding(
                        padding: EdgeInsets.only(top: 300.h),
                        child: Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: const Color(0xFF000080),
                            size: 50,
                          ),
                        ),
                      );
                    } else if (state
                        is UserNearestTailorDetailLoadedSuccessState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 120.h,
                                height: 120.h,
                                margin: EdgeInsets.only(left: 20.w),
                                decoration: BoxDecoration(
                                    color: const Color(0XFFcce0fe),
                                    borderRadius: BorderRadius.circular(15)),
                                child: (state
                                        .nearestTailor.profilePicture.isEmpty)
                                    ? Image.asset(
                                        "assets/images/sample_profile_image.png",
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            state.nearestTailor.profilePicture,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  state.nearestTailor.name,
                                  style: TextStyle(
                                      fontFamily: "Roboto-Medium",
                                      fontSize: 26.sp),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30.h,
                                bottom: 30.h,
                                left: 20.w,
                                right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: fields
                                      .map((field) => Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(field,
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                              ))))
                                      .toList(),
                                ),
                                SizedBox(
                                    width: 20
                                        .w), // Add some space between the columns
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          state.nearestTailor.phone,
                                          style: TextStyle(
                                              fontFamily: "Roboto-Regular",
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          width: 180.w,
                                          child: AutoSizeText(
                                            state.nearestTailor.email,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            maxFontSize: 16,
                                            minFontSize: 10,
                                            style: TextStyle(
                                                fontFamily: "Roboto-Regular",
                                                fontSize: 16.sp,
                                                color: Colors.black),
                                          )),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          '${widget.distance} KM away',
                                          style: TextStyle(
                                              fontFamily: "Roboto-Regular",
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10, top: 5),
                                        child: AutoSizeText(
                                          state.nearestTailor.address,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          maxFontSize: 16,
                                          minFontSize: 10,
                                          style: TextStyle(
                                              fontFamily: "Roboto-Regular",
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10.h, left: 20.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Service Summary",
                                  style: TextStyle(
                                      fontFamily: "Roboto-Medium",
                                      fontSize: 24.sp,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 250.w,
                            margin: EdgeInsets.only(
                                bottom: 30.h, left: 20.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.nearestTailor.servicesSummary,
                                  style: TextStyle(
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (state.nearestTailor.services!.isEmpty)
                            Container(
                              height: 100.h,
                              width: 250.w,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: const Color(0xFF000080), width: 1),
                              ),
                              child: Text(
                                "Not Services from this Tailor!",
                                style: TextStyle(
                                    fontSize: 18.sh, color: Colors.black),
                              ),
                            ),
                          if (!state.nearestTailor.services!.isEmpty)
                            Container(
                              width: 250.w,
                              margin: EdgeInsets.only(bottom: 10.h),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: const Color(0xFF000080), width: 1),
                              ),
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount:
                                    2, // Number of items in each row
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 2 /
                                    1, // Adjust the aspect ratio (width / height)
                                children: List.generate(
                                    state.nearestTailor.services!.length,
                                    (index) {
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return popupWidget(
                                            service: state
                                                .nearestTailor.services![index],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal:
                                              10), // Adjust the vertical value
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: const Color(0xFF000080),
                                            width: 1),
                                      ),
                                      child: Center(
                                        child: Text(state.nearestTailor
                                            .services![index].name),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 40.h,
                                left: 10.w,
                                right: 10.w,
                                top: 40.h),
                            child: ElevatedButton(
                              onPressed: () {
                                if (state.nearestTailor.services!.isEmpty) {
                                  EasyLoading.showError(
                                      "You can't book appointment with this Tailor as there are no services from this Tailor!",
                                      duration: const Duration(seconds: 5),
                                      dismissOnTap: true);
                                  return;
                                } else if (state
                                    .nearestTailor.dropOffDates!.isEmpty) {
                                  EasyLoading.showError(
                                      "You can't book appointment with this Tailor as there are no drop off dates from this Tailor!",
                                      duration: const Duration(seconds: 5),
                                      dismissOnTap: true);
                                  return;
                                } else if (state
                                    .nearestTailor.pickupDates!.isEmpty) {
                                  EasyLoading.showError(
                                      "You can't book appointment with this Tailor as there are no pick up dates from this Tailor!",
                                      duration: const Duration(seconds: 5),
                                      dismissOnTap: true);
                                  return;
                                } else {
                                  context.push(
                                      '/${AppRouteNames.userBookServicePage}',
                                      extra: state.nearestTailor);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: Size(300.w, 70.h),
                                backgroundColor: const Color(0xFF000080),
                              ),
                              child: Text(
                                "Book Appointment",
                                style: TextStyle(
                                  fontSize: 25.h,
                                  fontFamily: "Roboto-Medium",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar:
    );
  }
}
