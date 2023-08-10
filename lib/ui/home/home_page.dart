import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui//home/viewmodels/home_page_viewmodel.dart';
import 'package:jacksi_test/ui/home/widgets/categories.dart';
import '../../../data/database/database.dart' as db;
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../../injection_container.dart';
import 'dart:io';
import '../add_product/add_product_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomePageViewModel model =
      HomePageViewModel(sl<Repository>());
  String type = "أفقي";

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 26.h,
            ),
            SizedBox(
              height: 50.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddProductsPage()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "المنتجات",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "التصنيفات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            // --------------Categories-------------
            Categories(model:model),
            SizedBox(
              height: 12.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder<ViewType>(
                  valueListenable: model.selectedViewType,
                  builder: (context, value, _) {
                    return Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          if (value == ViewType.vertical) {
                            type = "عمودي";
                          } else {
                            type = "أفقي";
                          }
                          if (value == ViewType.vertical) {
                            model.selectViewType(ViewType.horizontal);
                          } else {
                            model.selectViewType(ViewType.vertical);
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Container(
                            height: 36.h,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "تغيير عرض المنتجات الى $type",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        color: AppColors.red1),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SvgPicture.asset(AppImages.menuIcon),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Text(
                                                    product.productName,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'Montserrat'),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        product.price
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .green1,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      const Text(
                                                        "دولار",
                                                        textAlign:
                                                            TextAlign.start,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.blue1,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints
                                                        .tightFor(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: AppColors.grey1),
                                                    height: 31.h,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        product.storeName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                AppColors.grey2,
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
                                          padding: EdgeInsets.only(
                                              right: 16.w, top: 13.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Text(
                                                    product.productName,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'Montserrat'),
                                                    textAlign: TextAlign.left,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        product.price
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .green1,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      const Text(
                                                        "دولار",
                                                        textAlign:
                                                            TextAlign.start,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.blue1,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints
                                                        .tightFor(),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: AppColors.grey1),
                                                    height: 31.h,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        product.storeName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color:
                                                                AppColors.grey2,
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
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18),
                            ),
                          );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
