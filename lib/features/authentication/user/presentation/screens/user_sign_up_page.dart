// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  late UserAuthBloc _userAuthBloc;
  @override
  void initState() {
    super.initState();
    _userAuthBloc = BlocProvider.of<UserAuthBloc>(context);
  }

  final prefManager = sl<SharedPrefManager>();

  void _handleSignUp() {
    final email = emailController.text;
    final password = passwordController.text;
    final name = fullNameController.text;
    final phoneNumber = phoneNumberController.text;
    final address = addressController.text;
    User user = User(
        name: name,
        email: email,
        password: password,
        address: address,
        phone: phoneNumber,
        user_type: prefManager.getString('user-type')!,
        fcm_token: "");
    _userAuthBloc.add(SignUpUserEvent(user: user));
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
          "User Sign Up",
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextFormField(
                    controller: fullNameController,
                    style: TextStyle(fontSize: 20.h),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      hintText: "Full name",
                      hintStyle: TextStyle(fontSize: 20.h),
                    ),
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(fontSize: 20.h),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      contentPadding: EdgeInsets.only(bottom: 12),
                      hintStyle: TextStyle(fontSize: 20.h),
                    ),
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
                  ),
                ),
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
                          setState(
                            () {
                              _obscureText = !_obscureText;
                            },
                          );
                        },
                      ),
                    ),
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextFormField(
                    controller: phoneNumberController,
                    style: TextStyle(fontSize: 20.h),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      hintText: "Phone Number",
                      hintStyle: TextStyle(fontSize: 20.h),
                    ),
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
              BlocConsumer<UserAuthBloc, UserAuthState>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    EasyLoading.showSuccess("Successful created user account!",
                        duration: const Duration(seconds: 2),
                        dismissOnTap: true);

                    Future.delayed(const Duration(seconds: 2), () {
                      context.go(
                        '/${AppRouteNames.userLogin}',
                      );
                    });
                  } else if (state is SignUpFailureState) {
                    EasyLoading.showError(state.errormessage,
                        dismissOnTap: true,
                        duration: const Duration(seconds: 2));
                  }
                },
                builder: (context, state) {
                  if (state is UserAuthLoadingState) {
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
              BlocBuilder<UserAuthBloc, UserAuthState>(
                builder: (context, state) {
                  if (state is UserAuthLoadingState ||
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
                              context.go(
                                '/${AppRouteNames.userLogin}',
                              );
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
