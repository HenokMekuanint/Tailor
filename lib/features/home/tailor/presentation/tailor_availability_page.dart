import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route.dart';
import 'package:mobile/features/drop_off_date/presentation/bloc/drop_off_date_bloc.dart';
import 'package:mobile/features/home/tailor/presentation/widgets/tailor_availability_widget.dart';
import 'package:mobile/features/pick_up_date/presentation/bloc/pick_up_date_bloc.dart';

class TailorAvailabilityPage extends StatefulWidget {
  const TailorAvailabilityPage({super.key});

  @override
  State<TailorAvailabilityPage> createState() => _TailorAvailabilityPageState();
}

class _TailorAvailabilityPageState extends State<TailorAvailabilityPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<PickUpDateBloc>(context).add(
      const GetPickUpDatesEvent(),
    );

    BlocProvider.of<DropOffDateBloc>(context).add(
      const GetDropOffDatesEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Availability",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   primary: true,
          //   pinned: true,
          //   expandedHeight: 100,
          //   collapsedHeight: 100,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Padding(
          //       padding: EdgeInsets.only(top: 50.h, left: 20.w, bottom: 20.h),
          //       child: Text(
          //         "Availability",
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 30.sp,
          //           fontFamily: 'Poppins',
          //           fontWeight: FontWeight.w700,
          //           height: 0,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0.h),
              child: PickUpOrDropOffDateTitleWithActions(
                title: 'Drop off dates',
                isDropOffDate: true,
              ),
            ),
          ),
          BlocConsumer<DropOffDateBloc, DropOffDateState>(
            listener: (context, state) {
              if (state is DropOffDateErrorState) {
                EasyLoading.showError(state.message,
                    duration: const Duration(seconds: 3), dismissOnTap: true);
              }
            },
            builder: (context, state) {
              if (state is GetDropOffDatesSuccessState) {
                if (state.dropOffDateEntities.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No drop off dates"),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => InkWell(
                        onTap: () {
                          context.go(
                              '/${AppRouteNames.tailorEditDropOffDateScreen}',
                              extra: state.dropOffDateEntities[index]);
                        },
                        child: AvailabilityWidget(
                          dropOffDateEntity: state.dropOffDateEntities[index],
                        ),
                      ),
                      childCount: state.dropOffDateEntities.length,
                    ),
                  );
                }
              } else if (state is DropOffDateErrorState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: const Color(0xFF000080),
                      size: 30,
                    ),
                  ),
                );
              }
            },
          ),
          const SliverToBoxAdapter(
            child: PickUpOrDropOffDateTitleWithActions(
              title: 'Pick up dates',
            ),
          ),
          BlocConsumer<PickUpDateBloc, PickUpDateState>(
            listener: (context, state) {
              if (state is PickUpDateErrorState) {
                EasyLoading.showError(state.message,
                    duration: const Duration(seconds: 3), dismissOnTap: true);
              }
            },
            builder: (context, state) {
              if (state is GetPickUpDatesSuccessState) {
                if (state.pickUpDateEntities.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No pick up dates"),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => InkWell(
                        onTap: () {
                          context.go(
                              '/${AppRouteNames.tailorEditPickUpDateScreen}',
                              extra: state.pickUpDateEntities[index]);
                        },
                        child: PickUpDateAvailabilityWidget(
                          pickUpDateEntity: state.pickUpDateEntities[index],
                        ),
                      ),
                      childCount: state.pickUpDateEntities.length,
                    ),
                  );
                }
              } else if (state is PickUpDateErrorState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: const Color(0xFF000080),
                      size: 30,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class PickUpOrDropOffDateTitleWithActions extends StatelessWidget {
  const PickUpOrDropOffDateTitleWithActions({
    super.key,
    required this.title,
    this.isDropOffDate = false,
  });
  final String title;
  final bool isDropOffDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isDropOffDate) {
                    context.go('/${AppRouteNames.tailorAddDropOffDateScreen}');
                  } else {
                    context.go('/${AppRouteNames.tailorAddPickUpDateScreen}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: Size(100.w, 60.h),
                  backgroundColor: const Color(0xFF000080),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.add,
                      size: 24.h,
                      color: Colors.white,
                    ),
                    Text(isDropOffDate ? "Add" : 'Add',
                        style: TextStyle(color: Colors.white, fontSize: 16.h)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Date"), Text("From"), Text("To")],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
