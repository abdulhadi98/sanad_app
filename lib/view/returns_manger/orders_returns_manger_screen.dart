import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:wits_app/controller/orders_controller.dart';
import 'package:wits_app/controller/returns_manger/returns_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/bottom_nav_bar.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/header_widget.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/order_widget.dart';
import 'package:wits_app/view/common_wigets/return_widget.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../../../helper/enums.dart';
import '../../../../helper/utils.dart';

class OrdersScreentReturnsManger extends StatelessWidget {
  final GlobalController globalController = Get.find<GlobalController>();
  final returnsController = Get.put<ReturnsController>(
    ReturnsController(),
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                        title: "مسؤول المرتجعات",
                        scaffoldKey: scaffoldKey,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Expanded(child: Obx(() {
                        switch (returnsController.status!.value) {
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
                            return returnsController.returnsList.length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: returnsController.returnsList.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return ReturnWidget(
                                        onTap: () {
                                          OrdersRootScreen.orderId = returnsController.returnsList[i].id;
                                          if (Get.arguments['api'] == "/get-returns")
                                            Get.toNamed(
                                              '/recive-returns-screen',
                                              arguments: {
                                                "returns_id": returnsController.returnsList[i].id.toString(),
                                              },
                                            );

                                          // OrdersRootScreen.orderId = returnsController.ordersList[i].id;
                                          // switch (returnsController.ordersList[i].status!.status) {
                                          //   case 'استلام طلب جديد':
                                          //     {
                                          //       if (returnsController.ordersList[i].isPrinted == 1)
                                          //         Get.toNamed('/order-details-screen');
                                          //       else
                                          //         Get.toNamed('/print-order-movament-manger-screen');
                                          //       break;
                                          //     }
                                          //   case 'تم التحضير':
                                          //     {
                                          //       OrdersRootScreen.orderId = returnsController.ordersList[i].id;
                                          //       Get.toNamed('/Order-details-movament-manger-screen');
                                          //       break;
                                          //     }
                                          //   default:
                                          //     Get.toNamed('order-details-screen');
                                          //     break;
                                          // }
                                        },
                                        salesmanName: returnsController.returnsList[i].clientName ?? 'null',
                                        // title: returnsController.ordersList[i].name ?? 'null',
                                        // clientNumber: returnsController.ordersList[i].invoiceNumber!.toString(),
                                        // mainColor: returnsController.ordersList[i].status!.color,
                                        // sideColor: returnsController.ordersList[i].status!.secondColor,
                                        // type: 'delegation'
                                      );
                                    })
                                : Center(child: Utils.errorText(text: 'لا يوجد طلبيات حالياً'));
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
