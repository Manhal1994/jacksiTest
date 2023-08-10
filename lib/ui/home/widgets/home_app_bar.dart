import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../add_product/add_product_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(),
          Positioned(
            left: 0,
            top: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddProductsPage()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "المنتجات",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
