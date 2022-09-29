import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/general/notes_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/note_widget.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/header_widget.dart';

class NotesScreen extends StatelessWidget {
  //final GlobalController globalController = Get.find<GlobalController>();
  final NotesController notesController = Get.put<NotesController>(
    NotesController(),
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
            await notesController.getNotes();
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
                          switch (notesController.status!.value) {
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
                              return notesController.notesList.length > 0
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: notesController.notesList.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return NoteWidget(onTap: () {
                                          OrdersRootScreen.orderId = notesController.notesList[i].orderId;
                                          Get.toNamed(
                                            '/note-detials-screen',
                                            arguments: {
                                              "note_id": notesController.notesList[i].id.toString(),
                                            },
                                          );
                                        }

                                            // OrdersRootScreen.orderId = notesController.notesList[i].id;
                                            // switch (notesController.notesList[i].status!.status) {
                                            //   case 'استلام طلب جديد':
                                            //     {
                                            //       if (notesController.notesList[i].isPrinted == 1)
                                            //         Get.toNamed('/order-details-screen');
                                            //       else
                                            //         Get.toNamed('/print-order-movament-manger-screen');
                                            //       break;
                                            //     }
                                            //   case 'تم التحضير':
                                            //     {
                                            //       OrdersRootScreen.orderId = notesController.notesList[i].id;
                                            //       Get.toNamed('/Order-details-movament-manger-screen');
                                            //       break;
                                            //     }
                                            //   default:
                                            //     Get.toNamed('order-details-screen');
                                            //     break;
                                            // }

                                            );
                                      })
                                  : Center(child: Utils.errorText(text: 'لا يوجد ملاحظات حالياً'));
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
