import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductAppBar extends StatelessWidget {
  const AddProductAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
