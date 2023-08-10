import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:jacksi_test/ui/screens/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui/screens/home/viewmodels/home_page_viewmodel.dart';
import '../../../data/database/database.dart' as db;
import '../../../images.dart';
import '../../../injection_container.dart';
import 'dart:io';

import '../add_product/add_product_page.dart';


class HomePage extends StatefulWidget {
  final ProductsScreenViewModel model =
      ProductsScreenViewModel(sl<Repository>());

  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String type = "أفقي";

  @override
  void didChangeDependencies() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F4),
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
                              builder: (context) => AddProductsPage()));
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
            SizedBox(
              height: 118.h,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return state is CategoryLoaded
                      ? ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: state.categories.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? ValueListenableBuilder<db.Category?>(
                                    valueListenable:
                                        widget.model.selectedCategory,
                                    builder: (context, category, _) {
                                      return Material(
                                          child: InkWell(
                                        onTap: () {
                                          widget.model.selectCategory(null);
                                        },
                                        child: Container(
                                          width: 96.w,
                                          height: 114.h,
                                          margin: EdgeInsets.only(right: 8.w),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: category == null
                                                  ? Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff3EB86F))
                                                  : null,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  child: Container(
                                                    width: 82.w,
                                                    height: 66.h,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Color(
                                                                0xff3EB86F)),
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                      AppImages
                                                          .allCategoriesIcon,
                                                      width: 27.w,
                                                      height: 28.h,
                                                    )),
                                                  )),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    state
                                                        .categories[index].name,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ));
                                    })
                                : ValueListenableBuilder<db.Category?>(
                                    valueListenable:
                                        widget.model.selectedCategory,
                                    builder: (context, category, _) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            widget.model.selectCategory(
                                                state.categories[index - 1]);
                                          },
                                          child: Container(
                                            width: 96.w,
                                            height: 114.h,
                                            margin: EdgeInsets.only(right: 8.w),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: category?.id ==
                                                        state
                                                            .categories[
                                                                index - 1]
                                                            .id
                                                    ? Border.all(
                                                        width: 1,
                                                        color: const Color(
                                                            0xff3EB86F))
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                    child: Image.asset(
                                                      state
                                                          .categories[index - 1]
                                                          .image,
                                                      width: 82.w,
                                                      height: 66.h,
                                                      fit: BoxFit.cover,
                                                    )),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      state
                                                          .categories[index - 1]
                                                          .name,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 12),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder<ViewType>(
                  valueListenable: widget.model.selectedViewType,
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
                          if (value ==
                              ViewType.vertical) {
                            widget.model.selectViewType(ViewType.horizontal);
                          } else {
                            widget.model.selectViewType(ViewType.vertical);
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
                                        color: Color(0xffFF4155)),
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
                  valueListenable: widget.model.products,
                  builder: (context, products, _) {
                    return ValueListenableBuilder<ViewType>(
                        valueListenable: widget.model.selectedViewType,
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
                                                textDirection:
                                                    TextDirection.rtl,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    product.price.toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                          0xff3EB86F,
                                                        ),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Montserrat',
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
                                                        color: Color(
                                                          0xff3E3E68,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
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
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: const Color(
                                                        0xffEEEEEE)),
                                                height: 31.h,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    product.storeName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xffA1A1A1),
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    product.price.toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                          0xff3EB86F,
                                                        ),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Montserrat',
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
                                                        color: Color(
                                                          0xff3E3E68,
                                                        ),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
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
                                                    BoxConstraints.tightFor(),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: const Color(
                                                        0xffEEEEEE)),
                                                height: 31.h,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    product.storeName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xffA1A1A1),
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
                        });
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
