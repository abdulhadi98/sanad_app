import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';

import 'dilog_custom.dart';

class DialogContentAreYouSure extends StatelessWidget {
  DialogContentAreYouSure({this.onYes});
//  final Function() onTap;
  Function? onYes;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              // color: AppColors.white.withOpacity(0.9),
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Icon Close Light-1.svg',
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TitleWidget(tilte: 'هل أنت متأكد؟'),
                  SizedBox(
                    height: 185.h,
                  ),
                  MainButton(
                    text: 'لا',
                    width: 232.w,
                    color: AppColors.red,
                    height: 50.h,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  MainButton(
                    text: 'نعم',
                    width: 232.w,
                    //    color: AppColors.red,
                    height: 50.h,
                    onPressed: () {
                      Get.back();
                      onYes!();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
