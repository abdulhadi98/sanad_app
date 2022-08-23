import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/orders_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/bottom_nav_bar.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/header_widget.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/order_widget.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../../../helper/enums.dart';
import '../../../../helper/utils.dart';

class MovmentMangerRootScreen extends StatelessWidget {
  MovmentMangerRootScreen({Key? key}) : super(key: key);

  final GlobalController globalController = Get.find<GlobalController>();
  final put = Get.put<OrdersController>(
    OrdersController(),
  );
  final OrdersController ordersController = Get.find<OrdersController>();
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
                        title: "مدير الحركة",
                        scaffoldKey: scaffoldKey,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Expanded(child: Obx(() {
                        switch (ordersController.status!.value) {
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
                                child: Utils.errorText(''),
                              ),
                            );

                          case Status.DATA:
                            return Container(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: ordersController.ordersList.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return OrderWidget(
                                        onTap: () {
                                          OrdersRootScreen.orderId = ordersController.ordersList[i].id;
                                          Get.toNamed('/Order-details-movament-manger-screen');
                                          // OrdersRootScreen.orderId = ordersController.ordersList[i].id;
                                          // switch (ordersController.ordersList[i].status!.status) {
                                          //   case 'استلام طلب جديد':
                                          //     {
                                          //       if (ordersController.ordersList[i].isPrinted == 1)
                                          //         Get.toNamed('/order-details-screen');
                                          //       else
                                          //         Get.toNamed('/print-order-movament-manger-screen');
                                          //       break;
                                          //     }
                                          //   case 'تم التحضير':
                                          //     {
                                          //       OrdersRootScreen.orderId = ordersController.ordersList[i].id;
                                          //       Get.toNamed('/Order-details-movament-manger-screen');
                                          //       break;
                                          //     }
                                          //   default:
                                          //     Get.toNamed('order-details-screen');
                                          //     break;
                                          // }
                                        },
                                        title: ordersController.ordersList[i].name!,
                                        clientNumber: ordersController.ordersList[i].invoiceNumber!.toString(),
                                        mainColor: ordersController.ordersList[i].status!.color,
                                        sideColor: ordersController.ordersList[i].status!.secondColor,
                                        type: 'delegation');
                                  }),
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
