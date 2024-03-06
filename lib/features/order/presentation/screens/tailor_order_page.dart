import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route.dart';
import 'package:mobile/features/order/presentation/screens/tailor_order_card.dart';
import 'package:mobile/features/order/presentation/bloc/order_bloc.dart';

class TailorOrderPage extends StatefulWidget {
  const TailorOrderPage({super.key});

  @override
  State<TailorOrderPage> createState() => _TailorOrderPageState();
}

class _TailorOrderPageState extends State<TailorOrderPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(TailorGetOrdersEvent());
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
          "Orders",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
            //   child: Text(
            //     "Orders",
            //     style: TextStyle(
            //       fontSize: 30.h,
            //       fontFamily: "Roboto-Medium",
            //     ),
            //   ),
            // ),
            BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderFailureState) {
                  EasyLoading.showError(state.failureMessage,
                      duration: const Duration(seconds: 3), dismissOnTap: true);
                }
              },
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xFF000080),
                        size: 50,
                      ),
                    ),
                  );
                } else if (state is OrderFailureState) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 40.w, top: 300.h),
                    child: Center(child: Text(state.failureMessage)),
                  );
                } else if (state is OrderSuccessState) {
                  if (state.orders.isEmpty) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 40.w, right: 40.w, top: 300.h),
                      child: Center(
                          child: Text(
                        "No orders yet",
                        style: TextStyle(color: Colors.red[500]),
                      )),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                  '/${AppRouteNames.tailorOrderDetailPage}',
                                  extra: state.orders[index]);
                            },
                            child: TailorOrderCard(order: state.orders[index]),
                          );
                        },
                      ),
                    );
                  }
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
