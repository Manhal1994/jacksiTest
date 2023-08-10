import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/entities/product_dto.dart';
import '../blocs/add_product/add_product_bloc.dart';
import '../viewmodels/add_product_viewmodel.dart';


class ProductAddButton extends StatelessWidget {
  final AddProductViewModel model;
  const ProductAddButton({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "تمت إضافة المنتج بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ProductDTO? productDTO =
                model.getProductDTO();
                if (productDTO != null) {
                  BlocProvider.of<AddProductBloc>(context)
                      .add(InsertProduct(productDTO));
                }
              },
              child: Container(
                height: 64.h,
                decoration: BoxDecoration(
                    color: state is AddProductLoading
                        ?Color(0x883EB86F)
                        : Color(0xff3EB86F)),
                child: Center(
                  child: Text(
                    "اضافه المنتج",
                    style: TextStyle(
                        fontSize: 18.sp,
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
    );
  }
}
