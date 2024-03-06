import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final int? ratingCount;
  const RatingBar(
      {super.key, required this.rating, this.size = 18.0, this.ratingCount});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];
    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();
    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(Icon(
          Icons.star,
          color: Color(0xFFefb110),
          size: size,
        ));
      } else if (i == realNumber) {
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.star,
                color: Color(0xFFefb110),
                size: size,
              ),
              ClipRect(
                clipper: _Cliper(part: partNumber),
                child: Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: size,
                ),
              )
            ],
          ),
        ));
      } else {
        _starList.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Cliper extends CustomClipper<Rect> {
  final int part;
  _Cliper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
