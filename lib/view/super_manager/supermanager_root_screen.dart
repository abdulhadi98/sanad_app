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

class SuperManagerRootScreen extends StatelessWidget {
  static var salesmanId;
  //final GlobalController globalController = Get.find<GlobalController>();
  final salesEmployeeController = Get.put<SalesEmployeeController>(
    SalesEmployeeController(),
  ); // or optionally with tag
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
                        title: 'مسؤول التحكم',
                      ),
                      SizedBox(
                        height: 49.h,
                      ),
                      MainButton(
                        text: 'أضف طلبية جديدة',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/add-new-order-super-manager-screen', arguments: {'role_name': "مسؤول التحكم"});
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'تعيين موظف مبيعات',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () async {
                          await salesEmployeeController.getSalesEmployees();
                          showDialogCustom(
                            height: height,
                            width: width,
                            context: context,
                            padding: EdgeInsets.zero,
                            dialogContent: StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  color: AppColors.white,
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
                                      Text(
                                        'تعيين موظف المبيعات',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textColorXDarkBlue,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 6.h),
                                        child: Divider(
                                          color: AppColors.textColorXDarkBlue,
                                          indent: width / 2.3,
                                          endIndent: width / 2.3,
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        //   padding: EdgeInsets.symmetric(vertical: 5.),
                                        height: height / 1.3,
                                        width: width,
                                        child: ListView.builder(
                                            itemCount: salesEmployeeController.salesEmployeesList.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return WorkerWidget(
                                                  imageUrl: salesEmployeeController.salesEmployeesList[index].imagePorofile ?? 'assets/images/worker1.png',
                                                  workerName: salesEmployeeController.salesEmployeesList[index].name!,
                                                  workerDepartment: 'قسم المبيعات',
                                                  onPressed: () {
                                                    salesEmployeeController.employeeId = salesEmployeeController.salesEmployeesList[index].id;
                                                    SalesMangerRootScreen.salesmanId = salesEmployeeController.salesEmployeesList[index].id;
                                                    print(salesEmployeeController.employeeId);
                                                    Get.toNamed('/send_order_to_sales_employee', arguments: {'sales_employee_id': salesEmployeeController.salesEmployeesList[index].id});
                                                    // Get.toNamed(
                                                    //     '/order-details-screen');
                                                  });
                                            }),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
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
                          Get.toNamed('/super-manager-orders-screen', arguments: {'api': "/get-orders"});
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      MainButton(
                        text: 'إضافة تقييم',
                        width: 224.w,
                        height: 50.h,
                        onPressed: () {
                          Get.toNamed('/choose-review-type-supermanager-screen');
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
