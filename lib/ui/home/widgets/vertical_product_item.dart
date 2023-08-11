import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';

class VerticalProductItem extends StatelessWidget {
  final ProductDTO product;
  final HomePageViewModel model;
  const VerticalProductItem({Key? key,required this.product,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 16.w, bottom: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(12.r),
            child: File(product.images[0]).existsSync()? Image.file(
              File(product.images[0]),
              width: 114.h,
              height: 114.h,
              fit: BoxFit.cover,
            ):Image.asset(AppImages.productImage,  width: 114.h,
              height: 114.h,),
          ),
          SizedBox(
            width: 14.w,
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                product.productName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.formatPrice(product.price.toString()),
                    style: const TextStyle(
                        color: AppColors.green1,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight:
                        FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  const Text(
                    "دولار",
                    textAlign: TextAlign.start,
                    textDirection:
                    TextDirection.rtl,
                    style: TextStyle(
                        color: AppColors.blue1,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight:
                        FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Container(

                padding: EdgeInsets.symmetric(
                    horizontal: 16.w),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(8.r),
                    color: AppColors.grey1),
                height: 31.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    product.storeName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                        color: AppColors.grey2,
                        fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
