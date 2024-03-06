// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/update_profile_pic/tailor_update_profile_pic_bloc.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class TailorUpdateProfilePictureScreen extends StatefulWidget {
  final TailorModel? loggedInTailor;
  TailorUpdateProfilePictureScreen({
    Key? key,
    this.loggedInTailor,
  }) : super(key: key);

  @override
  State<TailorUpdateProfilePictureScreen> createState() =>
      _TailorUpdateProfilePictureScreenState();
}

class _TailorUpdateProfilePictureScreenState
    extends State<TailorUpdateProfilePictureScreen> {
  File? imageFile;
  XFile? profilePictureFile;
  final prefManager = sl<SharedPrefManager>();
  Future<void> selectImage() async {
    try {
      final XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        setState(() {
          profilePictureFile = selectedImage;
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<File> storeImage(String imagePath) async {
    final directory = await getApplicationCacheDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    String oldProfilePic =
        prefManager.getString(SharedPrefKeys.profilePictureUrl) ?? "";
    debugPrint("update profile pic screen: oldProfilePic: $oldProfilePic");
    // Validate the selected image
    void _validateSelectedImages() {
      if (profilePictureFile != null) {
        // Dispatch an event to upload the selected image
        BlocProvider.of<TailorUpdateProfilePicBloc>(context).add(
            TailorUpdateProfilePicEventStarted(myFile: profilePictureFile!));
      } else {
        // Show a toast message if the selected images is invalid

        EasyLoading.showToast('Please select photo to upload');
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.sp,
            ),
            onPressed: () {
              context.pop(context);
            },
          ),
          elevation: 10,
          centerTitle: true,
          toolbarHeight: 80.h,
          backgroundColor: Color(0xFF000080),
          shadowColor: Colors.white,
          title: Text(
            "Update Profile Picture",
            style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontSize: 30.h,
                color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w, top: 40.h),
                    height: 250.h,
                    width: 250.h,
                    child: CircleAvatar(
                      radius: 125.r,
                      backgroundImage: profilePictureFile != null
                          ? FileImage(File(profilePictureFile!.path))
                          : oldProfilePic.isNotEmpty
                              ? NetworkImage(oldProfilePic)
                                  // CachedNetworkImage(
                                  //     imageUrl: oldProfilePic,
                                  //     placeholder: (context, url) =>
                                  //         CircularProgressIndicator(),
                                  //     errorWidget: (context, url, error) =>
                                  //         Icon(Icons.error),
                                  //   )
                                  as ImageProvider<Object>?
                              : AssetImage(
                                  "assets/images/sample_profile_image.png"),
                    ),
                  ),
                ],
              ),
            ),

            // Select Image Button
            Padding(
              padding: EdgeInsets.only(bottom: 50.h, top: 50.h),
              child: ElevatedButton(
                onPressed: () {
                  selectImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF000080),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 10.h), // Set padding
                ),
                child: Text(
                  "Select Image",
                  style: TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 20.h,
                      color: Colors.white),
                ),
              ),
            ),

            // Upload Image Button
            if (profilePictureFile != null)
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: BlocConsumer<TailorUpdateProfilePicBloc,
                    TailorUpdateProfilePicState>(
                  listener: (context, state) {
                    if (state is TailorUpdateProfilePicSuccessState) {
                      EasyLoading.showSuccess('Profile Picture Updated');
                      Future.delayed(Duration(seconds: 2), () {
                        context.pop();
                      });
                    } else if (state is TailorUpdateProfilePicErrorState) {
                      EasyLoading.showError(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is TailorUpdateProfilePicLoadingState) {
                      return ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000080),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          fixedSize: Size(200.w, 70.h), // Set padding
                        ),
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.white,
                          size: 30.h,
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          _validateSelectedImages();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000080),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h), // Set padding
                        ),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                              fontFamily: "Roboto-Medium",
                              fontSize: 20.h,
                              color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
          ]),
        ));
  }
}
