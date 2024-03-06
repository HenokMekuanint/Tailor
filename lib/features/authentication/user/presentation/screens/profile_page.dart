import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';

import 'package:mobile/features/home/client/presentation/widgets/logout_popup_widget.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? loggedInUser;

  @override
  void initState() {
    getLoggedInUserInfo();
    super.initState();
  }

  final prefManager = sl<SharedPrefManager>();

  void getLoggedInUserInfo() {
    String? loggedInUserString =
        prefManager.getString(SharedPrefKeys.loggedInUserInfo);

    if (loggedInUserString != null && loggedInUserString.isNotEmpty) {
      loggedInUser = UserModel.fromJson(jsonDecode(loggedInUserString));
    }
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        prefManager.getString(SharedPrefKeys.profilePictureUrl) ?? "";
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 90.h),
                    child: CircleAvatar(
                      radius: 65.r,
                      backgroundImage: (profileImageUrl.isEmpty)
                          ? const AssetImage(
                              "assets/images/sample_profile_image.png")
                          : NetworkImage(profileImageUrl)
                              // CachedNetworkImage(
                              //     imageUrl: profileImageUrl,
                              //     placeholder: (context, url) =>
                              //         CircularProgressIndicator(),
                              //     errorWidget: (context, url, error) =>
                              //         Icon(Icons.error),
                              //   )
                              as ImageProvider,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 80.w, top: 180.h),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                            AppRouteNames.userUpdateProfilePictureScreen,
                            extra: loggedInUser);
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18.r,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 25.r,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF000080),
                          ),
                        ),
                        const Text("Profile"),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .pushNamed(AppRouteNames.userProfileDetailScreen);
                        },
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 25.sp,
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: const Divider(
                  color: Color(0xFFC9C9C9),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Color(0xFF000080),
                          ),
                        ),
                        const Text("Logout"),
                      ],
                    ),
                    BlocConsumer<UserAuthBloc, UserAuthState>(
                      listener: (context, state) {
                        if (state is SignOutSuccessState) {
                          context.go('/${AppRouteNames.onboarding}');
                        } else if (state is SignOutFailureState) {
                          EasyLoading.showError(state.errormessage,
                              duration: const Duration(seconds: 2),
                              dismissOnTap: true);
                        }
                      },
                      builder: (context, state) {
                        if (state is SignOutLoadingState) {
                          return IconButton(
                              onPressed: () {},
                              icon: LoadingAnimationWidget.fourRotatingDots(
                                  color: const Color(0xFF000080), size: 20));
                        } else if (state is SignOutSuccessState) {
                          return Container();
                        } else {
                          return IconButton(
                              onPressed: () async {
                                final bool isYes = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const LogoutPopupWidget();
                                  },
                                );

                                if (isYes) {
                                  Future.delayed(Duration.zero, () async {
                                    context.read<UserAuthBloc>().add(
                                        SignOutUserEvent(user_type: "user"));
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.chevron_right_rounded,
                                size: 25.sp,
                              ));
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                child: const Divider(
                  color: Color(0xFFC9C9C9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
