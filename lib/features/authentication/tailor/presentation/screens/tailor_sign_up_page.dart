import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/tailor_auth_bloc.dart';

import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class TailorSignUpPage extends StatefulWidget {
  const TailorSignUpPage({super.key});

  @override
  State<TailorSignUpPage> createState() => _TailorSignUpPageState();
}

class _TailorSignUpPageState extends State<TailorSignUpPage> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController serviceSummeryController =
      TextEditingController();

  final prefManager = sl<SharedPrefManager>();

  void _handleSignUp() {
    final email = emailController.text;
    final password = passwordController.text;
    final name = fullNameController.text;
    final phoneNumber = phoneNumberController.text;
    final address = addressController.text;
    final tailorSummery = serviceSummeryController.text;
    Tailor tailor = Tailor(
        name: name,
        email: email,
        password: password,
        address: address,
        phoneNumber: phoneNumber,
        user_type: 'tailor',
        latitude: prefManager.getDouble(SharedPrefKeys.latitude) ?? 10.0,
        longitude: prefManager.getDouble(SharedPrefKeys.longitude) ?? 10.0,
        services_summary: tailorSummery);

    BlocProvider.of<TailorAuthBloc>(context).add(
      SignUpTailorEvent(tailor: tailor),
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
          "Tailor Sign Up",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    "Welcome to ThreadMe!",
                    style: TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 30.h,
                      color: const Color(0xFF000080),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: Text("Enter your details to create account.",
                    style: TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 20.h,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                width: 280.w,
                height: 80.h,
                padding: const EdgeInsets.only(left: 20, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    controller: fullNameController,
                    style: TextStyle(
                      fontSize: 20.h,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 12),
                        hintText: "Full name",
                        hintStyle: TextStyle(fontSize: 20.h)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                width: 280.w,
                height: 80.h,
                padding: const EdgeInsets.only(left: 20, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(fontSize: 20.h),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 12),
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 20.h)),
                  ),
                ),
              ),
              Container(
                  width: 280.w,
                  height: 80.h,
                  margin: EdgeInsets.only(bottom: 30.h),
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFECECEC), // Set the border color
                        width: 1.0,
                      )),
                  child: Center(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      style: TextStyle(fontSize: 20.h),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 20.h),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                width: 280.w,
                height: 80.h,
                padding: const EdgeInsets.only(left: 20, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    controller: phoneNumberController,
                    style: TextStyle(fontSize: 20.h),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 12),
                        hintText: "Phone Number",
                        hintStyle: TextStyle(fontSize: 20.h)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                width: 280.w,
                height: 80.h,
                padding: const EdgeInsets.only(left: 20, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    controller: addressController,
                    style: TextStyle(
                      fontSize: 20.h,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 12),
                        hintText: "Address",
                        hintStyle: TextStyle(fontSize: 20.h)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                width: 280.w,
                height: 150.h,
                padding: const EdgeInsets.only(left: 20, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFECECEC),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: serviceSummeryController,
                  maxLines: 5,
                  style: TextStyle(fontSize: 20.h, height: 2),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Service Summary",
                      hintStyle: TextStyle(fontSize: 20.h)),
                ),
              ),
              BlocConsumer<TailorAuthBloc, TailorAuthState>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    EasyLoading.showSuccess(
                        "Successful created tailor account!",
                        duration: const Duration(seconds: 2),
                        dismissOnTap: true);
                    Future.delayed(const Duration(seconds: 2), () {
                      context.go(
                        '/${AppRouteNames.tailorLoginPage}',
                      );
                    });
                  } else if (state is SignUpFailureState) {
                    EasyLoading.showError(state.errormessage,
                        duration: const Duration(seconds: 2),
                        dismissOnTap: true);
                  }
                },
                builder: (context, state) {
                  if (state is TailorAuthLoadingState) {
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
                  } else if (state is SignUpSuccessState) {
                    return Container();
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        _handleSignUp();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: Size(300.w, 70.h),
                        backgroundColor: const Color(0xFF000080),
                      ),
                      child: Text(
                        "Sign Up",
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
              BlocBuilder<TailorAuthBloc, TailorAuthState>(
                builder: (context, state) {
                  if (state is SignInLoadingState ||
                      state is SignUpSuccessState) {
                    return Container();
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ?",
                            style: TextStyle(fontFamily: "Roboto-Regular"),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/${AppRouteNames.tailorLoginPage}');
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color(0xFF000080),
                                  fontSize: 20.sp,
                                  fontFamily: "Roboto-Regular"),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
