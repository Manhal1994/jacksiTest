import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreNameInputField extends StatelessWidget {
  final TextEditingController controller;
  const StoreNameInputField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD9D9D9), width: 1.w),
            borderRadius: BorderRadius.circular(
              14.r,
            ),
            color: Colors.white),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            decoration: InputDecoration.collapsed(
                hintText: 'اسم المتجر',
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Montserrat',
                    color: const Color(0xffD9D9D9),
                    fontWeight: FontWeight.w300),
                hintTextDirection: TextDirection.rtl),
          ),
        ));
  }
}
