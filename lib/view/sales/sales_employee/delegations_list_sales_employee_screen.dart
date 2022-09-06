import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/delegations_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/sales_employee_delegations_controller.dart';
import 'package:wits_app/view/common_wigets/bottom_nav_bar.dart';
import 'package:wits_app/view/common_wigets/delegation_widget.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/header_widget.dart';
import 'package:wits_app/view/sales/sales_manger/orders/order_from_salesperson_screen.dart';

import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../../controller/global_controller.dart';
import '../../../../../helper/enums.dart';
import '../../../../../helper/utils.dart';

class DelegationsListSalesEmployeeScreen extends StatelessWidget {
  final GlobalController globalController = Get.find<GlobalController>();

  final put = Get.put<SalesEmployeeDelegationsController>(
    SalesEmployeeDelegationsController(),
  );
  final SalesEmployeeDelegationsController delegationsController = Get.find<SalesEmployeeDelegationsController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //

    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        height: 3.h,
                      ),
                      Expanded(child: Obx(() {
                        switch (delegationsController.status!.value) {
                          case Status.LOADING:
                            return SizedBox(
                              height: height / 1.5,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          case Status.ERROR:
                            return SizedBox(
                              height: height / 1.5,
                              child: Center(
                                child: Utils.errorText(),
                              ),
                            );

                          case Status.DATA:
                            return Container(
                              child: delegationsController.delegationsList.length > 0
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: delegationsController.delegationsList.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return DelegationWidget(
                                            salesmanName: delegationsController.delegationsList[i].delegationEmployeeName ?? "مدير المبيعات",
                                            onTap: () {
                                              print(delegationsController.delegationsList[i].id);

                                              SalesmanOrderScreen.delegationId = delegationsController.delegationsList[i].id;
                                              Get.toNamed('/add-order-from-delegation-sales-employee-screen', arguments: {'delegation_id': delegationsController.delegationsList[i].id});
                                            }
                                            // title: ordersController
                                            //     .delegationsList[i].name!,
                                            // clientNumber: ordersController
                                            //     .delegationsList[i].invoiceNumber!
                                            //     .toString(),
                                            // mainColor: ordersController
                                            //     .delegationsList[i].status!.color,
                                            // sideColor: ordersController
                                            //     .delegationsList[i].status!.secondColor,
                                            // type: 'delegation'
                                            );
                                      })
                                  : Center(child: Utils.errorText(text: 'لا يوجد طلبيات حالياً')),
                            );
                        }
                      })),
                    ],
                  ),
                ),

                //  if (WidgetsBinding.instance?.window.viewInsets.bottom! > 0.0)
                if (!isKeyboardShowing)
                  buildBottomNavBar(
                    width,
                    height,
                    false,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SalesMangerRootScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
