import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

import '../../../../../injection/injection_container.dart';

class UserProfileDetailPage extends StatefulWidget {
  const UserProfileDetailPage({super.key});

  @override
  State<UserProfileDetailPage> createState() => _UserProfileDetailPageState();
}

class _UserProfileDetailPageState extends State<UserProfileDetailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  UserModel? loggedInUser;

  @override
  void initState() {
    super.initState();
    getLoggedInUserInfo();

    context.read<UserAuthBloc>().add(GetLoggedInUserInfoEvent());
  }

  final prefManager = sl<SharedPrefManager>();

  void getLoggedInUserInfo() {
    String? loggedInUserString =
        prefManager.getString(SharedPrefKeys.loggedInUserInfo);

    if (loggedInUserString != null && loggedInUserString.isNotEmpty) {
      loggedInUser = UserModel.fromJson(jsonDecode(loggedInUserString));
      _nameController.text = loggedInUser?.name ?? "";
      _phoneNumberController.text = loggedInUser?.phone ?? "";
      _emailController.text = loggedInUser?.email ?? "";
      _addressController.text = loggedInUser?.address ?? "";
    } else {
      context.go('/${AppRouteNames.userLogin}}');
    }
  }

  @override
  Widget build(BuildContext context) {
    String profileImageUrl =
        prefManager.getString(SharedPrefKeys.profilePictureUrl) ?? "";
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
          "Profile details",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 40.h),
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
                  // Container(
                  //   margin: EdgeInsets.only(left: 80.w, top: 135.h),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       print("Pressed");
                  //     },
                  //     child: CircleAvatar(
                  //       radius: 20.r,
                  //       backgroundColor: Colors.white,
                  //       child: CircleAvatar(
                  //         radius: 18.r,
                  //         child: Icon(
                  //           Icons.edit,
                  //           color: Colors.white,
                  //           size: 25.r,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
              child: const Text(
                "Name",
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h, left: 30.w),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFECECEC),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                controller: _nameController,
                style: TextStyle(fontSize: 20.h),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Full name",
                    hintStyle: TextStyle(fontSize: 20.h)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                child: const Text(
                  "Phone number",
                )),
            Container(
              margin: EdgeInsets.only(bottom: 10.h, left: 30.w),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFECECEC),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                readOnly: true,
                controller: _phoneNumberController,
                style: TextStyle(fontSize: 20.h),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "+123456789",
                    hintStyle: TextStyle(fontSize: 20.h)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                child: const Text(
                  "Email",
                )),
            Container(
              margin: EdgeInsets.only(bottom: 10.h, left: 30.w),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFECECEC),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                readOnly: true,
                controller: _emailController,
                style: TextStyle(fontSize: 20.h),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle: TextStyle(fontSize: 20.h)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                child: const Text(
                  "Address",
                )),
            Container(
              margin: EdgeInsets.only(bottom: 30.h, left: 30.w),
              width: 320.w,
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
                  controller: _addressController,
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
              margin: EdgeInsets.symmetric(vertical: 40.h),
              child: BlocConsumer<UserAuthBloc, UserAuthState>(
                listener: (context, state) {
                  if (state is GetLoggedInUserInfoFailureState) {
                    EasyLoading.showError(state.errormessage);

                    context.go('/${AppRouteNames.userLogin}}');
                  } else if (state is UpdateProfileSuccessState) {
                    EasyLoading.showSuccess("Profile Updated Successfully!",
                        duration: const Duration(seconds: 3),
                        dismissOnTap: true);
                  }
                  if (state is UpdateProfileFailureState) {
                    EasyLoading.showError(state.errormessage,
                        duration: const Duration(seconds: 3),
                        dismissOnTap: true);
                  }
                },
                builder: (context, state) {
                  if (state is UpdateProfileLoadingState) {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fixedSize: Size(300.w, 70.h),
                            backgroundColor: const Color(0xFF000080),
                          ),
                          child: LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white, size: 20)),
                    );
                  } else {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            UserUpdateProfileEntity userUpdateProfileEntity =
                                UserUpdateProfileEntity(
                                    name: _nameController.text,
                                    address: _addressController.text);

                            context.read<UserAuthBloc>().add(
                                UpdateProfileUserEvent(
                                    userUpdateProfileEntity:
                                        userUpdateProfileEntity));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fixedSize: Size(300.w, 70.h),
                            backgroundColor: const Color(0xFF000080),
                          ),
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.h,
                                fontFamily: "Roboto-Medium"),
                          )),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
