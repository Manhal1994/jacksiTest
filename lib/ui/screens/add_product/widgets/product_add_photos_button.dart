import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../images.dart';
import '../viewmodels/add_product_viewmodel.dart';


class ProductAddPhotosButton extends StatelessWidget {
  final AddProductViewModel model;
  const ProductAddPhotosButton({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              model.pickImage();
            },
            child: Container(
              height: 60.h,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff3EB86F)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "اضغط لاضافة الصور",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  SvgPicture.asset(
                    AppImages.addIcon,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
