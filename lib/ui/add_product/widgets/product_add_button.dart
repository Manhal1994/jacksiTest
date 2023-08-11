import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jacksi_test/res/app_colors.dart';
import 'package:jacksi_test/ui/add_product/widgets/show_toast.dart';
import '../../../../data/dto/product_dto.dart';
import '../blocs/add_product/add_product_bloc.dart';
import '../viewmodels/add_product_viewmodel.dart';

class ProductAddButton extends StatelessWidget {
  final AddProductViewModel model;
  const ProductAddButton({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 36.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            if (state is AddProductSuccess) {
              Navigator.of(context).pop();
              showSuccessToast("تمت إضافة المنتج بنجاح");
            } else if (state is AddProductFail) {
              showErrorToast(state.message);
            }
          },
          builder: (context, state) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ProductDTO? productDTO = model.getProductDTO();
                  if (productDTO != null) {
                    BlocProvider.of<AddProductBloc>(context)
                        .add(InsertProduct(productDTO));
                  }
                },
                child: Container(
                  height: 64.h,
                  decoration: BoxDecoration(
                      color: state is AddProductLoading
                          ? AppColors.green2
                          : AppColors.green1),
                  child: Center(
                    child: Text(
                      "اضافه المنتج",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
