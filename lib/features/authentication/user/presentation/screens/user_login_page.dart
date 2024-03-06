import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';

import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final prefManager = sl<SharedPrefManager>();

  void _handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;

    UserLogin user = UserLogin(
      email: email,
      password: password,
      user_type: prefManager.getString('user-type')!,
    );
    print('${user.email} --- email');
    print('${user.password} --- password');
    print('${user.user_type} --- user type');
    BlocProvider.of<UserAuthBloc>(context).add(SignInUserEvent(user: user));
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
          "User Sign In",
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
                    "Welcome back to ThreadMe!",
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
                child: Text(
                  "Enter your email and password to Sign In.",
                  style: TextStyle(
                    fontFamily: "Roboto-Regular",
                    fontSize: 20.h,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 30.h,
                ),
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
                      contentPadding: EdgeInsets.only(bottom: 10),
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 20.h),
                    ),
                  ),
                ),
              ),
              Container(
                width: 280.w,
                height: 80.h,
                margin: EdgeInsets.only(bottom: 80.h),
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
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<UserAuthBloc, UserAuthState>(
                listener: (context, state) {
                  if (state is SignInSuccessState) {
                    EasyLoading.showSuccess('Successfully logged in',
                        dismissOnTap: true,
                        duration: const Duration(seconds: 2));
                    Future.delayed(const Duration(seconds: 2), () {
                      context.go(
                        '/${AppRouteNames.userMainPage}',
                      );
                    });
                  } else if (state is SignInFailureState) {
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
                  } else if (state is SignInSuccessState) {
                    return Container();
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        _handleLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: Size(300.w, 70.h),
                        backgroundColor: const Color(0xFF000080),
                      ),
                      child: Text(
                        "Login",
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
                      state is SignInSuccessState) {
                    return Container();
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(
                                '/${AppRouteNames.userSignUp}',
                              );
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: const Color(0xFF000080),
                                fontSize: 20.sp,
                                fontFamily: "Roboto-Regular",
                              ),
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
