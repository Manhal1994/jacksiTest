import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/data/repository.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'package:jacksi_test/ui/home/widgets/categories.dart';
import 'package:jacksi_test/ui/home/widgets/home_app_bar.dart';
import 'package:jacksi_test/ui/home/widgets/product_list.dart';
import 'package:jacksi_test/ui/home/widgets/products_view_type.dart';
import '../../res/app_colors.dart';
import '../../../injection_container.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomePageViewModel model = HomePageViewModel(sl<Repository>());

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
            // --------------App bar-------------
            const HomeAppBar(),

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
            Categories(model: model),
            SizedBox(
              height: 12.h,
            ),
            //-------------- Products view type----------------
            ProductsViewType(
              model: model,
            ),
            SizedBox(
              height: 16.h,
            ),
            //-------------- Products----------------

            ProductList(model: model)
          ],
        ),
      )),
    );
  }
}
