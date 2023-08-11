import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui/home/widgets/view_all_category.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'category_item.dart';

class Categories extends StatelessWidget {
  final HomePageViewModel model;

  const Categories({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
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
                        ? ViewAllCategory(model: model)
                        : CategoryItem(
                            model: model,
                            item: state.categories[index - 1],
                          );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
