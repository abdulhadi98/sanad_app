import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wits_app/helper/utils.dart';

class DelegationWidget extends StatelessWidget {
  final String? salesmanName;
  // final String? clientNumber;
  // final dynamic mainColor;
  // final dynamic sideColor;
  // final String type;
  final Function() onTap;

  const DelegationWidget({Key? key, required this.onTap, this.salesmanName}) : super(key: key);

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
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width / 1.29,
                  height: 70.h,
                  color: Color(0xFF366A8E),
                  child: Text(
                    "طلبية من $salesmanName", //salesman name id creator id but I can't edit it now
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width - width / 1.29,
                  height: 70.h,
                  color: Color(0xFF1C415A),
                  child: SvgPicture.asset(
                    'assets/icons/Icon Arrow.svg',
                    height: 14.w,
                    width: 8.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
