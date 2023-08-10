import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/database/database.dart';
import '../../../res/app_images.dart';
import '../../home/blocs/category/category_bloc.dart';
import '../viewmodels/add_product_viewmodel.dart';


class ProductCategory extends StatelessWidget {
  final AddProductViewModel model;
  const ProductCategory({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state is CategoryLoaded
            ? PopupMenuButton<Category?>(
                initialValue: null,
                onSelected: (category) {
                  model.selectCategory(category);
                },
                itemBuilder: (context) => state.categories
                    .map((e) =>
                        PopupMenuItem<Category>(value: e, child: Text(e.name)))
                    .toList(),
                child: ClipRRect(
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xffD9D9D9), width: 1.w),
                            borderRadius: BorderRadius.circular(
                              14.r,
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(AppImages.dropDownIcon),
                                ValueListenableBuilder<Category?>(
                                  valueListenable: model.productCategory,
                                  builder: (context, value, _) => Text(
                                    value?.name ?? "التصنيف",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Montserrat',
                                        color: const Color(0xff5973DE),
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ]),
                        ))),
              )
            : state is CategoryLoading
                ? const CircularProgressIndicator()
                : const Text("خطأ");
      },
    );
  }
}
