import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/sales_employee_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/dilog_custom.dart';
import '../common_wigets/header_widget.dart';

class ChooseReviewTypeScreen extends StatelessWidget {
  //final GlobalController globalController = Get.find<GlobalController>();

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
                        title: 'المدير العام',
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      MainButton(
                          text: 'تقييم موظف',
                          width: 224.w,
                          height: 50.h,
                          onPressed: () {
                            Get.toNamed('/review-by-department-screen');
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'تقييم حسب طلبية معينة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/review-by-order-screen', arguments: {'api': "/get-orders"});
                        },
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
