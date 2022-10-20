import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/network/urls_container.dart';

import '../../helper/app_colors.dart';

Widget buildBottomNavBar(
  width,
  height,
  isAddAvalible,
  onTap,
) {
  return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          height: 70.h,
          width: width,
          color: AppColors.background,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (isAddAvalible)
                Positioned(
                  top: -41.w,
                  right: width / 2 - 41.w,
                  child: ClipOval(
                    child: InkWell(
                      onTap: () {
                        if (sharedPreferences!.getInt('role') == 13)
                          Get.toNamed('/add-new-order-super-manager-screen');
                        else
                          Get.toNamed(
                            '/add-new-order-screen',
                            arguments: {
                              'role_name': sharedPreferences!.getInt('role') == 4
                                  ? "موظف قسم المبيعات"
                                  : sharedPreferences!.getInt('role') == 11
                                      ? "المدير العام"
                                      : "مدير قسم المبيعات"
                            },
                          );
                        print('asdasdasd');
                      },
                      child: Container(
                        width: 82.w,
                        height: 82.w,
                        padding: EdgeInsets.all(11.w),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.background,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mainColor1.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 17,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          width: 60.w,
                          height: 60.w,
                          child: SvgPicture.asset(
                            'assets/icons/ic_add_order.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                //  bottom: 0,

                child: Row(mainAxisAlignment: isAddAvalible ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceEvenly, children: [
                  if (!isAddAvalible)
                    buildBottomNavBarItem(false, 'assets/icons/Icon Back Light.svg', 'رجوع', () {
                      print(Get.currentRoute);
                      String route = Utils.getRouteFromRole();
                      if (Get.currentRoute != route) Get.back();
                    }),
                  buildBottomNavBarItem(
                    false,
                    'assets/icons/Icon Home Active.svg',
                    'الرئيسية',
                    () {
                      print('sds');
                      print(Get.currentRoute);
                      String route = Utils.getRouteFromRole();
                      if (Get.currentRoute != route) Get.offAllNamed(route);
                    },
                  ),
                  buildBottomNavBarItem(false, 'assets/icons/Icon Search Dark.svg', 'بحث', () async {
                    print(Get.currentRoute);
                    bool isManager = await Utils.isThisRoleManager();
                    print(isManager);
                    String searchRoute = '/search_screen';

                    if (Get.currentRoute != searchRoute) {
                      if (isManager) {
                        Get.toNamed(searchRoute, arguments: {'api': '/search-manager'});
                      } else {
                        Get.toNamed(searchRoute, arguments: {'api': '/search-employee'});
                      }
                    }
                  }),
                ]),
              ),
            ],
          ),
        );
      });
}

Widget buildBottomNavBarItem(isSelected, image, text, onTap, {size}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      //   color: Colors.amber,
      padding: EdgeInsets.only(bottom: 5.0.h, left: 20.w, top: 5.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: SvgPicture.asset(
              image,
              fit: BoxFit.contain,
              width: 18.w,
              height: 18.w,
              color: AppColors.mainColor1,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: AppColors.mainColor1, fontSize: 8.sp, fontWeight: FontWeight.bold),
          )

          // Container(
          //   width: 5.w,
          //   height: 5.w,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: isSelected ? Colors.white : Colors.transparent,
          //   ),
          // ),
        ],
      ),
    ),
  );
}
