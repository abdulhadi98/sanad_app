import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/app_colors.dart';

class TitleWidget extends StatelessWidget {
  final String tilte;
  const TitleWidget({
    required this.tilte,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0.h),
            child: Column(
              children: [
                Text(
                  tilte,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorXDarkBlue,
                  ),
                ),
                SizedBox(
                  width: 33.41.h,
                  child: Divider(
                    color: AppColors.textColorXDarkBlue,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
