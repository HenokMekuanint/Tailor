import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/core/utils/date_converter.dart';
import 'package:mobile/env/env.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/features/order/presentation/bloc/order_bloc.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class clientOrderDetailPage extends StatefulWidget {
  const clientOrderDetailPage({super.key, required this.order});
  final OrderEntity order;
  @override
  State<clientOrderDetailPage> createState() => _clientOrderDetailPageState();
}

class _clientOrderDetailPageState extends State<clientOrderDetailPage> {
  UserModel? loggedInUser;

  @override
  void initState() {
    final prefManager = sl<SharedPrefManager>();

    void getLoggedInUserInfo() {
      String? loggedInUserString =
          prefManager.getString(SharedPrefKeys.loggedInUserInfo);

      if (loggedInUserString != null && loggedInUserString.isNotEmpty) {
        loggedInUser = UserModel.fromJson(jsonDecode(loggedInUserString));
      } else {
        context.go('/${AppRouteNames.userLogin}}');
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
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
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
              //         style:
              //             TextStyle(fontSize: 28.sp, fontFamily: "Roboto-Medium"),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                  ),
                  child: Text(
                    "Tailor Detail",
                    style:
                        TextStyle(fontFamily: "Roboto-Medium", fontSize: 20.sp),
                  )),
              Container(
                width: 350.w, // Set the desired width
                height: 160.h,
                margin: EdgeInsets.only(
                    bottom: 10.h, left: 20.w, top: 20.h, right: 20.w),
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
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
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
                                  fontSize: 18.sp),
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 18.sp),
                            ),
                            Text(
                              "Address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 16.sp),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 14.sp),
                            ),
                            Text(
                              widget.order.email,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 14.sp),
                            ),
                            Text(
                              widget.order.address,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 14.sp),
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
                    style:
                        TextStyle(fontFamily: "Roboto-Medium", fontSize: 18.sp),
                  )),
              Container(
                margin: EdgeInsets.only(left: 45.w, top: 10.h),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 5.w),
                        child: SvgPicture.asset("assets/images/calendar.svg")),
                    Text(
                      formatDateTimeRange(
                        widget.order.dropOffDate[0],
                        widget.order.dropOffDate[1],
                      ),
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Text(
                    "Pick Up Date",
                    style:
                        TextStyle(fontFamily: "Roboto-Medium", fontSize: 18.sp),
                  )),
              Container(
                margin: EdgeInsets.only(left: 45.w, top: 10.h),
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
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  "Status",
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
                child: Text(
                  widget.order.status,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  "Payment Status",
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
                    Text(
                      widget.order.paymentStatus,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (widget.order.paymentStatus == 'pending')
                      SizedBox(
                        width: 150.w,
                        height: 60.h,
                        child: BlocConsumer<OrderBloc, OrderState>(
                          listener: (context, state) {
                            if (state is CompletePaymentFailureState) {
                              Fluttertoast.showToast(msg: state.failureMessage);
                            } else if (state is CompletePaymentSuccessState) {
                              Future.delayed(Duration(seconds: 1), () {
                                context.pop();
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is CompletePaymentLoadingState) {
                              return ElevatedButton(
                                onPressed: () {},
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: Color(0xFF000080),
                                  size: 22,
                                ),
                              );
                            } else if (state is CompletePaymentSuccessState) {
                              return Container();
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  stripeMakePayment();
                                },
                                // style: ElevatedButton.styleFrom(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0),
                                //   ),
                                //   fixedSize: Size(150.w, 60.h),
                                //   backgroundColor: const Color(0xFF000080),
                                // ),
                                child: Text("Pay Now"),
                              );
                            }
                          },
                        ),
                      ),
                  ],
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
                    color: const Color(0XFF0000080),
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
                          Text("Description",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 18.sp)),
                          Text(
                            widget.order.serviceDescription,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment() async {
    try {
      paymentIntent = await createPaymentIntent(
          widget.order.price.round().toString(), 'USD');
      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
                  billingDetails: stripe.BillingDetails(
                    name: loggedInUser?.name,
                    email: loggedInUser?.email,
                    phone: loggedInUser?.phone,
                  ),
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'ThreadMe'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
    } on Exception catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet().then((value) {
        debugPrint('payment data: ${value}');
      });

      BlocProvider.of<OrderBloc>(context).add(UserCompletePaymentEvent(
        id: widget.order.id.toString(),
      ));

      //TODO:ADD UPDATE ORDER MODEL EVENT HERE TO UPDATE THE ORDER WITH THE ID.
      //THE UPDATE PROCESS CHANGES THE "payment_status" OF THE ORDER FROM "pending" TO "completed"

      Fluttertoast.showToast(msg: 'Payment successfully completed');
    } on Exception catch (e) {
      if (e is stripe.StripeException) {
        throw Exception(
            'Error while trying to display stripe payment intent: ${e.error.localizedMessage}');
      } else {
        throw Exception(
            'Unknown error ocurred while trying to display stripe payment intent: ${e}');
      }
    }
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${Env.stripeTestSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(
          "Failed to create Stripe Payment Intent with error: ${err.toString()}");
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
