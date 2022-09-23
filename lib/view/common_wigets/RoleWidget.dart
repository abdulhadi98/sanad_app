import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wits_app/helper/app_colors.dart';

class RoleWidget extends StatelessWidget {
  final String? roleName;
  // final String? clientNumber;
  // final dynamic mainColor;
  // final dynamic sideColor;
  // final String type;
  final Function() onTap;

  const RoleWidget({Key? key, required this.onTap, this.roleName}) : super(key: key);

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
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width,
                  height: 70.h,
                  color: AppColors.mainColor2,
                  child: Text(
                    roleName!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
