import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/res/app_colors.dart';

class ProductList extends StatelessWidget {
  final HomePageViewModel model;
  const ProductList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<ProductDTO>>(
          valueListenable: model.products,
          builder: (context, products, _) {
            return products.isNotEmpty
                ? ValueListenableBuilder<ViewType>(
                    valueListenable: model.selectedViewType,
                    builder: (context, value, _) {
                      return value == ViewType.vertical
                          ? ListView.builder(
                              itemCount: products.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
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
                                        child: Image.file(
                                          File(product.images[0]),
                                          width: 114.h,
                                          height: 114.h,
                                          fit: BoxFit.cover,
                                        ),
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
                                                product.price.toString(),
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
                                            constraints:
                                                BoxConstraints.tightFor(),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
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
                              })
                          : ListView.builder(
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.only(right: 16.w, top: 13.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.file(
                                          File(product.images[0]),
                                          width: 114.h,
                                          height: 114.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
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
                                            textAlign: TextAlign.left,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            textDirection: TextDirection.rtl,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                product.price.toString(),
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
                                            height: 4.h,
                                          ),
                                          Container(
                                            constraints:
                                                const BoxConstraints.tightFor(),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
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
                              });
                    })
                : const Center(
                    child: Text(
                      "لا يوجد منتجات لعرضها",
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 18),
                    ),
                  );
          }),
    );
  }
}
