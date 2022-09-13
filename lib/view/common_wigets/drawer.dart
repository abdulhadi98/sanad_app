import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/global_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';

class AppDrawer extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  AppDrawer({required this.scaffoldKey});

  final put = Get.put<GlobalController>(
    GlobalController(),
  ); // or optionally with tag
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //  AppConstant.screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Theme(
              data: Theme.of(context).copyWith(
                // Set the transparency here
                canvasColor: Colors.white.withOpacity(
                  .88,
                ), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.22,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: Drawer(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 5.h,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.all(5.r),
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    globalController.closeDrawer(scaffoldKey);
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/icons/Icon Close Light-1.svg',
                                    width: 16.w,
                                    height: 16.w,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Center(
                            child: Text(
                              'سند',
                              style: TextStyle(color: AppColors.mainColor1, fontSize: 72.sp, fontWeight: FontWeight.bold, letterSpacing: 3, height: 1),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 32.h),
                              child: Text(
                                'تطبيق تتبع طلبات المستودعات من WITS',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColors.brownDark,
                                  fontSize: 14.sp,
                                  //    fontWeight: FontWeight.w500,
                                  //   letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          DrawerButton(
                            iconPath: 'assets/icons/Icon Home Active.svg',
                            title: "الرئيسية",
                          ),
                          //  SizedBox(height: .h),
                          Align(
                            alignment: Alignment.center,
                            child: LogoutButton(
                              text: 'تسجيل الخروج',
                              width: 178.w,
                              height: 50.h,
                              color: Colors.white,
                              onPressed: () async {
                                await sharedPreferences!.clear();
                                print(sharedPreferences!.getInt('role').toString());
                                Get.offAllNamed('/');
                              },
                            ),
                          )
                        ],
                      ),
                      // All other codes goes here.
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class LogoutButton extends StatelessWidget {
  final String text;
  double? height;
  final double width;
  final Color? color;
  final Function() onPressed;
  LogoutButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: color == null ? AppColors.mainColor1.withOpacity(0.5) : color!.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
          splashColor: color == null ? AppColors.mainColor2.withOpacity(0.5) : Colors.redAccent[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          color: color == null ? AppColors.mainColor1 : color,
          minWidth: width,
          height: height,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          textColor: AppColors.mainColor1,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String iconPath;

  final String title;

  DrawerButton({required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 34.h),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          SvgPicture.asset(
            iconPath,
            width: 18.w,
            height: 20.w,
          ),
          SizedBox(
            width: 17.w,
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: ('Bahij')),
          ),
        ],
      ),
    );
  }
}
