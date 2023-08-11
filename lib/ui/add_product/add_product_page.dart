import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jacksi_test/res/app_colors.dart';
import 'package:jacksi_test/ui/add_product/widgets/fields/product_name_input_field.dart';
import 'package:jacksi_test/ui/add_product/widgets/fields/product_price_input_field.dart';
import 'package:jacksi_test/ui/add_product/widgets/fields/store_name_input_field.dart';
import 'package:jacksi_test/ui/add_product/widgets/label.dart';
import 'package:jacksi_test/ui/add_product/widgets/product_add_button.dart';
import 'package:jacksi_test/ui/add_product/widgets/product_add_photos_button.dart';
import 'package:jacksi_test/ui/add_product/widgets/product_category.dart';
import 'package:jacksi_test/ui/add_product/widgets/product_image.dart';
import 'package:jacksi_test/ui/home/blocs/category/category_bloc.dart';
import '../../injection_container.dart';
import 'viewmodels/add_product_viewmodel.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({Key? key}) : super(key: key);

  @override
  AddProductsPageState createState() => AddProductsPageState();
}

class AddProductsPageState extends State<AddProductsPage> {
  final AddProductViewModel model = sl<AddProductViewModel>();
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.appBackgroundColor,
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
                      right: 0,
                      top: 0,
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: const BoxDecoration(color: Colors.white),
                              child: const Center(
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "اضافة منتجات",
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Montserrat',fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      const Label("صور المنتج"),
                      SizedBox(
                        height: 14.h,
                      ),
                      ValueListenableBuilder<List<String>>(
                          valueListenable: model.productImages,
                          builder: (context, value, _) {
                            return SizedBox(
                              height: 110.w,
                              child: value.isNotEmpty
                                  ? Align(
                                alignment: Alignment.centerRight,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        reverse: true,
                                        itemCount: value.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return ProductImage(
                                            imageFile: File(model
                                                .productImages.value[index]),
                                            onDelete: () {
                                              model
                                                  .deleteProductImage(index);
                                            },
                                          );
                                        }),
                                  )
                                  : const Text("لم تقم بإضافة أي صورة",style: TextStyle(fontFamily: 'Montserrat'),),
                            );
                          }),
                      SizedBox(
                        height: 14.h,
                      ),
                      ProductAddPhotosButton(model:model),
                      SizedBox(
                        height: 26.h,
                      ),
                      const Label("اسم المنتج"),
                      SizedBox(
                        height: 6.h,
                      ),
                      ProductNameInputField(
                        controller: model.productNameController,
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      const Label("اسم المتجر"),
                      SizedBox(
                        height: 6.h,
                      ),
                      StoreNameInputField(
                        controller: model.storeNameController,
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      const Label("السعر"),
                      SizedBox(
                        height: 6.h,
                      ),
                      ProductPriceInputField(
                        controller: model.priceController,
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      const Label("التصنيف"),
                      SizedBox(
                        height: 6.h,
                      ),
                      ProductCategory(model: model,),
                      SizedBox(
                        height: 32.h,
                      ),
                      ProductAddButton(model:model)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    model.productImages.dispose();
    model.productCategory.dispose();
    super.dispose();
  }
}
