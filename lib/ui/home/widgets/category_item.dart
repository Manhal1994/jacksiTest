import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/data/database/database.dart' as db;
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import '../../../res/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final HomePageViewModel model;
  final db.Category item;
  const CategoryItem({Key? key, required this.model, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<db.Category?>(
        valueListenable: model.selectedCategory,
        builder: (context, category, _) {
          return Container(
            width: 96.w,
            height: 114.h,
            margin: EdgeInsets.only(right: 8.w),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: category?.id ==
                   item.id
                    ? Border.all(
                    width: 1,
                    color: AppColors.green1)
                    : null,
                borderRadius:
                BorderRadius.circular(10.r)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  model.selectCategory(
                      item);
                },
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius:
                        BorderRadius.circular(9),
                        child: Image.asset(
                          item.image,
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
                          item.name,
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
  }
}
