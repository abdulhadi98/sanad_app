import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/global_controller.dart';
import 'package:wits_app/main.dart';

import '../../helper/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  final scaffoldKey;
  final put = Get.put<GlobalController>(
    GlobalController(),
  ); // or optionally with tag
  final GlobalController globalController = Get.find<GlobalController>();
  HeaderWidget({
    Key? key,
    // required this.scaffoldKey,
    required this.scaffoldKey,
    required this.width,
    required this.employeeName,
    required this.title,
  }) : super(key: key);

  final double width;
  final String employeeName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Container(
            //        alignment: Alignment.bottomCenter,
            width: width,
            height: 70.h + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 21.w,
                right: 21.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_orders_log_active.svg',
                    width: 16.w,
                    height: 17.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sharedPreferences!.getString('user_name') ?? '...',
                        style: TextStyle(
                          color: AppColors.mainColor1,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                          // height: 2,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w200,
                          //       height: 1,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      globalController.openDrawer(scaffoldKey);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/Icon Menu Dark.svg',
                      width: 15.w,
                      height: 16.w,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
