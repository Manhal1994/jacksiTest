import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_test/res/app_colors.dart';
import 'package:jacksi_test/res/app_images.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import '../../../data/database/database.dart' as db;
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';

class Categories extends StatelessWidget {
  final HomePageViewModel model;

  const Categories({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                            valueListenable: model.selectedCategory,
                            builder: (context, category, _) {
                              return Material(
                                  child: InkWell(
                                onTap: () {
                                  model.selectCategory(null);
                                },
                                child: Container(
                                  width: 96.w,
                                  height: 114.h,
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: category == null
                                          ? Border.all(
                                              width: 1, color: AppColors.green1)
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
                                            decoration: const BoxDecoration(
                                                color: AppColors.green1),
                                            child: Center(
                                                child: SvgPicture.asset(
                                              AppImages.allCategoriesIcon,
                                              width: 27.w,
                                              height: 28.h,
                                            )),
                                          )),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "عرض الكل",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12),
                                          ))
                                    ],
                                  ),
                                ),
                              ));
                            })
                        : ValueListenableBuilder<db.Category?>(
                            valueListenable: model.selectedCategory,
                            builder: (context, category, _) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    model.selectCategory(
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
                                                state.categories[index - 1].id
                                            ? Border.all(
                                                width: 1,
                                                color: AppColors.green1)
                                            : null,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            child: Image.asset(
                                              state.categories[index - 1].image,
                                              width: 82.w,
                                              height: 66.h,
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              state.categories[index - 1].name,
                                              style: const TextStyle(
                                                  fontFamily: 'Montserrat',
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
    );
  }
}
