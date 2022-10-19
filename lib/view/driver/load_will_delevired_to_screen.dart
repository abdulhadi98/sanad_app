import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:wits_app/controller/movment_manger/assign_driver_controller.dart';
import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/order_details_model.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/order_widget.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../../../controller/sales/add_new_order_screen_controller.dart';
import '../../helper/enums.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';
import 'dart:ui' as ui;

class LoadWillDeleviredScreen extends StatelessWidget {
  final putOrderDetailsController = Get.put<OrderDetailsController>(
    OrderDetailsController(),
  );
  final OrderDetailsController orderDetailsController = Get.find<OrderDetailsController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalController globalController = Get.find<GlobalController>();

//  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
      resizeToAvoidBottomInset: true,
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    HeaderWidget(
                      width: width,
                      employeeName: "اسم الموظف",
                      title: "السائق",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (orderDetailsController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (orderDetailsController.status!.value == Status.ERROR)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
                                  TitleWidget(tilte: 'تفاصيل الحمولة'),
                                  TextFieldCustom(
                                    enabled: false,
                                    hint: 'رقم العميل',
                                    textEditingController: orderDetailsController.clientNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldCustom(
                                    enabled: false,
                                    textEditingController: orderDetailsController.invoiceNumberController.value,
                                    hint: 'رقم الفاتورة',
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldCustom(
                                    enabled: false,
                                    hint: 'عدد الأصناف',
                                    textEditingController: orderDetailsController.categoriesNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false, height: 158.h,
                                    //focusNode: focusNode,
                                    hint: 'عنوان العميل',
                                    textEditingController: orderDetailsController.addressController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false,
                                    height: 158.h,
                                    textEditingController: orderDetailsController.detailsController.value,
                                    hint: 'تفاصيل الطلبية',
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldCustom(
                                    enabled: false,
                                    textEditingController: orderDetailsController.boxNumberController.value,
                                    hint: "عدد الصناديق",
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30.h),
                                    child: MainButton(
                                      text: 'تم الاستلام',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        //    await driversController.getDrivers();
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
                                                            child: Padding(
                            padding: EdgeInsets.only(bottom: 15.0.h, left: 15.w, top: 20.w, right: 15.w),
                                                              child: SvgPicture.asset(
                                                                'assets/icons/Icon Close Light-1.svg',
                                                                width: 16.w,
                                                                height: 16.w,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      'سيتم التسليم إلى',
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
                                                    SizedBox(
                                                      height: 30.h,
                                                    ),
                                                    Container(
                                                      //   padding: EdgeInsets.symmetric(vertical: 5.),
                                                      child: OrderWidget(
                                                        mainColor: '0xFF0194DB',
                                                        sideColor: '0xFF1178BA',
                                                        title: 'العميل',
                                                        type: '',
                                                        onTap: () {
                                                          Get.back();
                                                          Get.toNamed(
                                                            'deliver-to-client-screen',
                                                            arguments: {'order_id': orderDetailsController.orderDetailsModel!.id!},
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                      //   padding: EdgeInsets.symmetric(vertical: 5.),
                                                      child: OrderWidget(
                                                        mainColor: '0xFF0194DB',
                                                        sideColor: '0xFF1178BA',
                                                        title: 'سائق آخر',
                                                        type: '',
                                                        onTap: () {
                                                          Get.back();

                                                          Get.toNamed(
                                                            'deliver-to-driver-screen',
                                                            arguments: {'order_id': orderDetailsController.orderDetailsModel!.id!},
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                          }),
                        ),
                      ),
                    ),
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
          );
        },
      ),
    );
  }
}

