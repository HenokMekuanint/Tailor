import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';

import 'package:mobile/features/authentication/tailor/presentation/bloc/tailor_auth_bloc.dart';
import 'package:mobile/features/home/client/presentation/widgets/logout_popup_widget.dart';

import 'package:mobile/features/payment/presentation/bloc/tailor_create_stripe_account_link_bloc.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

import 'package:url_launcher/url_launcher.dart';

class TailorProfilePage extends StatefulWidget {
  const TailorProfilePage({super.key});

  @override
  State<TailorProfilePage> createState() => _TailorProfilePageState();
}

class _TailorProfilePageState extends State<TailorProfilePage> {
  TailorModel? loggedInTailor;
  final prefManager = sl<SharedPrefManager>();
  void getLoggedInTailorInfo() {
    String? loggedInTailorString =
        prefManager.getString(SharedPrefKeys.loggedInTailorInfo);

    if (loggedInTailorString != null && loggedInTailorString.isNotEmpty) {
      loggedInTailor = TailorModel.fromJson(jsonDecode(loggedInTailorString));
    }
  }

  @override
  void initState() {
    super.initState();
    getLoggedInTailorInfo();
  }

  @override
  Widget build(BuildContext context) {
    final String? profileImageUrl =
        prefManager.getString(SharedPrefKeys.profilePictureUrl);
    debugPrint("tailor profile image url: $profileImageUrl}");
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
                      backgroundImage:
                          (profileImageUrl == null || profileImageUrl.isEmpty)
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

                                  as ImageProvider<Object>?,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 80.w, top: 180.h),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                            AppRouteNames.tailorUpdateProfilePictureScreen,
                            extra: loggedInTailor);
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
                          context.push(
                              '/${AppRouteNames.tailorProfileDetailScreen}');
                        },
                        icon: Text(
                          String.fromCharCode(
                              CupertinoIcons.chevron_right.codePoint),
                          style: TextStyle(
                            inherit: false,
                            color: const Color(0xFF000080),
                            fontSize: 30.h,
                            fontWeight: FontWeight.w200,
                            fontFamily: CupertinoIcons
                                .exclamationmark_circle.fontFamily,
                            package: CupertinoIcons
                                .exclamationmark_circle.fontPackage,
                          ),
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
                    BlocConsumer<TailorAuthBloc, TailorAuthState>(
                      listener: (context, state) {
                        if (state is SignOutSuccessState) {
                          context.go('/${AppRouteNames.onboarding}');
                        } else if (state is SignOutFailureState) {
                          EasyLoading.showError(state.errormessage,
                              duration: const Duration(seconds: 3),
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
                                    context.read<TailorAuthBloc>().add(
                                        SignOutTailorEvent(
                                            user_type: "tailor"));
                                  });
                                }
                              },
                              icon: Text(
                                String.fromCharCode(
                                    CupertinoIcons.chevron_right.codePoint),
                                style: TextStyle(
                                  inherit: false,
                                  color: const Color(0xFF000080),
                                  fontSize: 30.h,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: CupertinoIcons
                                      .exclamationmark_circle.fontFamily,
                                  package: CupertinoIcons
                                      .exclamationmark_circle.fontPackage,
                                ),
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

              // Add Stripe Account Information
              if (loggedInTailor?.stripe_onboarding_completed == false)
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Connect Stripe"),
                        ],
                      ),
                      BlocConsumer<TailorCreateStripeAccountLinkBloc,
                          TailorCreateStripeAccountLinkState>(
                        listener: (context, state) {
                          if (state is TailorCreateStripeAccountLinkSuccess) {
                            EasyLoading.showSuccess(
                                state.tailorStripeConnectResponse.message
                                    .toString(),
                                duration: const Duration(seconds: 3),
                                dismissOnTap: true);
                          } else if (state
                              is TailorCreateStripeAccountLinkFailure) {
                            EasyLoading.showError(state.errorMessage,
                                duration: const Duration(seconds: 3),
                                dismissOnTap: true);
                          }
                        },
                        builder: (context, state) {
                          if (state is TailorCreateStripeAccountLinkLoading) {
                            return IconButton(
                                onPressed: () {},
                                icon: LoadingAnimationWidget.fourRotatingDots(
                                    color: const Color(0xFF000080), size: 20));
                          } else if (state
                              is TailorCreateStripeAccountLinkSuccess) {
                            return Container(
                              height: 60.h,
                              width: 190.w,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Uri uri = Uri.parse(state
                                        .tailorStripeConnectResponse
                                        .accountLink);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    } else {
                                      EasyLoading.showError(
                                          "Could not launch url",
                                          duration: const Duration(seconds: 3),
                                          dismissOnTap: true);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    fixedSize: Size(190.w, 60.h),
                                    backgroundColor: const Color(0xFF000080),
                                  ),
                                  child: Text(
                                    "Continue to Stripe",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            );
                          } else {
                            return IconButton(
                                onPressed: () async {
                                  Future.delayed(Duration.zero, () async {
                                    context
                                        .read<
                                            TailorCreateStripeAccountLinkBloc>()
                                        .add(
                                          CreateStripeLInk(),
                                        );
                                  });
                                },
                                icon: Text(
                                  String.fromCharCode(
                                      CupertinoIcons.chevron_right.codePoint),
                                  style: TextStyle(
                                    inherit: false,
                                    color: const Color(0xFF000080),
                                    fontSize: 30.h,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: CupertinoIcons
                                        .exclamationmark_circle.fontFamily,
                                    package: CupertinoIcons
                                        .exclamationmark_circle.fontPackage,
                                  ),
                                ));
                          }
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
