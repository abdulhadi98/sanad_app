import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';

import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class MovmentMangerRootScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          endDrawer: AppDrawer(
            scaffoldKey: scaffoldKey,
          ),
          body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      HeaderWidget(
                        scaffoldKey: scaffoldKey,
                        width: width,
                        employeeName: 'اسم الموظف',
                        title: 'مدير الحركة',
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      MainButton(
                        text: 'طلبيات غير مطبوعة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed(
                            '/orders-screen-movment-manger',
                            arguments: {
                              "api": "/get-unprinted-orders",
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'طلبيات تحتاج تعيين سائق',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed(
                            '/orders-screen-movment-manger',
                            arguments: {
                              "api": "/get-orders-need-driver",
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'طلبيات قيد التنفيذ',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed(
                            '/orders-screen-movment-manger',
                            arguments: {
                              "api": "/get-orders",
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                buildBottomNavBar(width, height, false, () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
