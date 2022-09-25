import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/super_manager/get_warehouses_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/app_constant.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../common_wigets/main_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChooseWarehouseScreen extends StatelessWidget {
  ChooseWarehouseScreen({Key? key}) : super(key: key);
  final GetWarehousesController getWarehousesController = Get.put<GetWarehousesController>(
    GetWarehousesController(),
  );
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppConstant.screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.r),
                      bottomRight: Radius.circular(40.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor1.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 30,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Utils.buildImage(url: 'assets/icons/header_logo.svg', height: 140.h)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                        width: width,
                        child: Obx(() {
                          if (getWarehousesController.status!.value == Status.LOADING)
                            return SizedBox(
                              height: height / 1.5,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          else if (getWarehousesController.status!.value == Status.ERROR)
                            return SizedBox(
                              height: height / 1.5,
                              child: Center(
                                child: Utils.errorText(),
                              ),
                            );
                          else
                            return SizedBox(
                              height: height / 2,
                              width: width,
                              child: ListView.builder(
                                  itemCount: getWarehousesController.warehousesList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        MainButton(
                                          text: getWarehousesController.warehousesList[index].name!,
                                          height: 50.h,
                                          width: 238.w,
                                          //    height: 50.h,
                                          onPressed: () async {
                                            await sharedPreferences!.setInt('warehouse_id', getWarehousesController.warehousesList[index].id!);
                                            print(sharedPreferences!.getInt('warehouse_id'));
                                            Get.toNamed('/super-manager-root-screen');
                                          },
                                        ),
                                        SizedBox(
                                          height: 27.h,
                                        ),
                                      ],
                                    );
                                  }),
                            );
                        })),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 26.h,
                  color: AppColors.brown,
                  child: Text(
                    '®WITS 2022 all right reserved',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 9.sp, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
