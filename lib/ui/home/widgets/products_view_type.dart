import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'package:jacksi_test/res/app_colors.dart';
import 'package:jacksi_test/res/app_images.dart';

class ProductsViewType extends StatelessWidget {
  final HomePageViewModel model;
  const ProductsViewType({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ValueListenableBuilder<ViewType>(
          valueListenable: model.selectedViewType,
          builder: (context, value, _) {
            String type = "أفقي";
            if (value == ViewType.horizontal) {
              type = "عمودي";
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    if (value == ViewType.vertical) {
                      model.selectViewType(ViewType.horizontal);
                    } else {
                      model.selectViewType(ViewType.vertical);
                    }
                  },
                  child: Container(
                    height: 36.h,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}
