import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile/core/utils/text_styles.dart';

import 'package:mobile/features/home/client/presentation/widgets/rating_bar.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailors.dart';

class tailorHomePageCard extends StatefulWidget {
  const tailorHomePageCard({super.key, required this.nearestTailorData});

  final NearestTailorData nearestTailorData;

  @override
  State<tailorHomePageCard> createState() => _tailorHomePageCardState();
}

class _tailorHomePageCardState extends State<tailorHomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 20.w, top: 20.h, right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15, // Adjust the blur radius as needed
            offset:
                Offset(0, 0), // Negative x value creates a shadow on the left
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5, // You can adjust the elevation as needed

        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0XFFcce0fe),
              ),
              margin: const EdgeInsets.all(10),
              width: 100.w,
              height: 125.h,
              child: widget.nearestTailorData.profilePicture.isEmpty
                  ? Image.asset(
                      "assets/images/sample_profile_image.png",
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.nearestTailorData.profilePicture,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 20.w, top: 5.h, bottom: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0XFFcce0fe),
                          borderRadius: BorderRadius.circular(15)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                      child: Center(
                          child: Text(
                        widget.nearestTailorData.name,
                        style: CustomTextStyles.blueNormalText,
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.nearestTailorData.servicesSummary,
                        style: TextStyle(
                          color: Color(0XFF0165FC),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Distance",
                              style: CustomTextStyles.blacksmallMediumText,
                            ),
                          ),
                          Container(
                            child: Text(
                              '${widget.nearestTailorData.distance} km',
                              style: CustomTextStyles.blacksmallMediumText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   child: Text(
                          //     "Address",
                          //     style: CustomTextStyles.blacksmallMediumText,
                          //   ),
                          // ),
                          Container(
                            child: AutoSizeText(
                              '${widget.nearestTailorData.address}',
                              style: CustomTextStyles.blacksmallMediumText,
                              minFontSize: 8,
                              maxFontSize: 16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const RatingBar(
                              rating: 3.5,
                              ratingCount: 12,
                            ),
                          ),
                          Container(
                            child: Text(
                              "3.5",
                              style: CustomTextStyles.blacksmallMediumText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
