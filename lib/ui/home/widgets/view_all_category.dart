import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../data/database/database.dart' as db;



class ViewAllCategory extends StatelessWidget {
  final HomePageViewModel model;
  const ViewAllCategory({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<db.Category?>(
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
        });
  }
}
