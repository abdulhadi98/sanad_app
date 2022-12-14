import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/sales_employee_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';

import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/dilog_custom.dart';
import '../../common_wigets/header_widget.dart';

class SalesMangerRootScreenNew extends StatelessWidget {
  static var salesmanId;
  //final GlobalController globalController = Get.find<GlobalController>();
  // or optionally with tag
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
                        title: 'مندوب المبيعات',
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      MainButton(
                        text: 'أضف طلبية جديدة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/salesman-root-screen');
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'طلبيات مرفوضة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/rejected_delegations_screen');
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                buildBottomNavBar(width, height, true, () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
