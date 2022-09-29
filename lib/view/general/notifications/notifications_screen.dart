import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/general/notification_controller.dart';
import 'package:wits_app/controller/sales/sales_employee_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/notification_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/dilog_custom.dart';
import '../../common_wigets/header_widget.dart';

class NotificationsScreen extends StatelessWidget {
  static var salesmanId;
  //final GlobalController globalController = Get.find<GlobalController>();
  final NotificationsController notificationsController = Get.put<NotificationsController>(
    NotificationsController(),
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
        return RefreshIndicator(
          displacement: 70,
          backgroundColor: AppColors.mainColor1,
          color: Colors.white,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 300));
            await notificationsController.getNotification();
          },
          child: Scaffold(
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
                          employeeName: 'الإشعارات',
                          title: '',
                        ),
                        Expanded(child: Obx(() {
                          switch (notificationsController.status!.value) {
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
                              return notificationsController.notifiationsList.length > 0
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: notificationsController.notifiationsList.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return NotificationWidget(
                                            title: notificationsController.notifiationsList[i].title ?? 'null',
                                            //  clientNumber: notificationsController.notifiationsList[i].invoiceNumber!.toString(),
                                            mainColor: notificationsController.notifiationsList[i].color!,
                                            sideColor: notificationsController.notifiationsList[i].secondColor!,
                                            type: notificationsController.notifiationsList[i].type!,
                                            onTap: () {
                                              print('orderid' + notificationsController.notifiationsList[i].orderId.toString());
                                              print('dele id' + notificationsController.notifiationsList[i].delegationId.toString());
                                              print('review id' + notificationsController.notifiationsList[i].reviewId.toString());
                                              print('returns id' + notificationsController.notifiationsList[i].returnsId.toString());

                                              print('xxxxxxxxxxxxx' + notificationsController.notifiationsList[i].action.toString());

                                              OrdersRootScreen.orderId = notificationsController.notifiationsList[i].orderId;

                                              if (notificationsController.notifiationsList[i].type == 'order') {
                                                if (notificationsController.notifiationsList[i].action == 'info') return;
                                                Get.toNamed(
                                                  Utils.getRouteFromNotificationOrder(notificationsController.notifiationsList[i].action),
                                                  arguments: {
                                                    "order_id": notificationsController.notifiationsList[i].orderId.toString(),
                                                  },
                                                );
                                              } else if (notificationsController.notifiationsList[i].type == 'delegation') {
                                                if (notificationsController.notifiationsList[i].action == 'info') return;
                                                Get.toNamed(
                                                  Utils.getRouteFromNotificationDelegation(notificationsController.notifiationsList[i].action),
                                                  arguments: {
                                                    "delegation_id": notificationsController.notifiationsList[i].delegationId.toString(),
                                                  },
                                                );
                                              } else if (notificationsController.notifiationsList[i].type == 'review') {
                                                Get.toNamed(
                                                  '/note-detials-screen',
                                                  arguments: {
                                                    "note_id": notificationsController.notifiationsList[i].reviewId.toString(),
                                                  },
                                                );
                                              } else if (notificationsController.notifiationsList[i].type == 'returns')
                                                Get.toNamed(
                                                  '/recive-returns-screen',
                                                  arguments: {
                                                    "returns_id": notificationsController.notifiationsList[i].returnsId.toString(),
                                                  },
                                                );
                                            }

                                            // OrdersRootScreen.orderId = notificationsController.notifiationsList[i].id;
                                            // switch (notificationsController.notifiationsList[i].status!.status) {
                                            //   case 'استلام طلب جديد':
                                            //     {
                                            //       if (notificationsController.notifiationsList[i].isPrinted == 1)
                                            //         Get.toNamed('/order-details-screen');
                                            //       else
                                            //         Get.toNamed('/print-order-movament-manger-screen');
                                            //       break;
                                            //     }
                                            //   case 'تم التحضير':
                                            //     {
                                            //       OrdersRootScreen.orderId = notificationsController.notifiationsList[i].id;
                                            //       Get.toNamed('/Order-details-movament-manger-screen');
                                            //       break;
                                            //     }
                                            //   default:
                                            //     Get.toNamed('order-details-screen');
                                            //     break;
                                            // }

                                            );
                                      })
                                  : Center(child: Utils.errorText(text: 'لا يوجد إشعارات حالياً'));
                          }
                        })),
                      ],
                    ),
                  ),
                  buildBottomNavBar(width, height, false, () {}),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
