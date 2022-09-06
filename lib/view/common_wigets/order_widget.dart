import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderWidget extends StatelessWidget {
  final String title;
  final String? clientNumber;
  final dynamic mainColor;
  final dynamic sideColor;
  final String type;
  final Function? onTap;
//  final Function() onTap;

  const OrderWidget({
    Key? key,
    this.onTap,
    required this.title,
    this.clientNumber,
    required this.mainColor,
    required this.sideColor,
    required this.type,
    //  required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            onTap!();
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width / 1.29,
                  height: 70.h,
                  color: Color(int.parse(mainColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    if(clientNumber!=null) Text(
                        clientNumber! + ' - ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width - width / 1.29,
                  height: 70.h,
                  color: Color(int.parse(sideColor)),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Icon Arrow.svg',
                      height: 14.w,
                      width: 8.w,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
