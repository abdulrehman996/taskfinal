import 'package:biz_link/utility/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'my_shimmers.dart';

class CircleImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const CircleImage({Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000.0),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl.toString().replaceAll(' ', '&'),
        width: widget.width ?? 5.h,
        height: widget.height ?? 5.h,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Shimmers.circleImageShimmerLoader();
        },
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(color: MyColor.accent_color),
          child: Icon(
            Icons.person_outline,
            size: 3.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
