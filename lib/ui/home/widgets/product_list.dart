import 'package:flutter/material.dart';
import 'package:jacksi_test/ui/home/viewmodels/home_page_viewmodel.dart';
import 'package:jacksi_test/data/dto/product_dto.dart';
import 'package:jacksi_test/ui/home/widgets/vertical_product_item.dart';

import 'horizontal_product_item.dart';

class ProductList extends StatelessWidget {
  final HomePageViewModel model;
  const ProductList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<ProductDTO>>(
          valueListenable: model.products,
          builder: (context, products, _) {
            return products.isNotEmpty
                ? ValueListenableBuilder<ViewType>(
                    valueListenable: model.selectedViewType,
                    builder: (context, value, _) {
                      return value == ViewType.vertical
                          ? ListView.builder(

                              itemCount: products.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return VerticalProductItem(product:product,model:model);
                              })
                          : ListView.builder(
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return HorizontalProductItem(product:product,model:model);
                              });
                    })
                : const Center(
                    child: Text(
                      "لا يوجد منتجات لعرضها",
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 18),
                    ),
                  );
          }),
    );
  }
}
