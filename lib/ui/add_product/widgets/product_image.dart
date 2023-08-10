import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';

import '../../../res/app_images.dart';

class ProductImage extends StatelessWidget {
  final File imageFile;
  final Function() onDelete;
  const ProductImage({Key? key,required this.imageFile,required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 96.75.w,
          height: 96.75.w,
          margin: EdgeInsets.only(left: 2.w),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
        ),
        Positioned(
          top: 0,
            left: 0,
            child: Image.file(imageFile,width: 96.75.w,height: 96.75.w,)),
        Positioned(
          top: 6.w,
          left: 6.w,
          child: GestureDetector(
            onTap: (){
              onDelete();
            },
              child: SvgPicture.asset(AppImages.deleteIcon,)
          ),
        )
      ],
    );
  }
}
