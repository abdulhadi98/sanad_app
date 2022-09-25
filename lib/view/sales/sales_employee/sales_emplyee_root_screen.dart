import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/add_new_order_screen.dart';

import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/header_widget.dart';

class SalesEmployeeRootScreen extends StatefulWidget {
  SalesEmployeeRootScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _SalesEmployeeRootScreenState createState() => _SalesEmployeeRootScreenState();
}

class _SalesEmployeeRootScreenState extends State<SalesEmployeeRootScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.mainColor1,
    //   statusBarBrightness: Brightness.dark,
    // ));
    double width = MediaQuery.of(context).size.width;
    //

    var mediaQuery = MediaQuery.of(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
          body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      HeaderWidget(
                        width: width,
                        employeeName: "اسم الموظف",
                        title: "موظف قسم المبيعات",
                        scaffoldKey: scaffoldKey,
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      MainButton(
                        text: 'أضف طلبية جديدة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/add-new-order-screen', arguments: {'role_name': "موظف قسم المبيعات"});
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'طلبيات جديدة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed(
                            '/delegations_list_sales_employee_screen',
                          );
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
