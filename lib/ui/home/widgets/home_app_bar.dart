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
                  final pageRouter = PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AddProductsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                        return  _transitionsBuilder(context, animation, secondaryAnimation, child);
                    },
                  );
                  Navigator.of(context).push(pageRouter);
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
 Widget  _transitionsBuilder (context, animation, secondaryAnimation, child){
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end)
        .chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
