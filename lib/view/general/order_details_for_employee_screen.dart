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
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/common_wigets/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../../../controller/sales/add_new_order_screen_controller.dart';
import '../../helper/enums.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';
import 'dart:ui' as ui;

class OrderDetailsForEmployeesSideMenuScreen extends StatelessWidget {
  final orderDetailsController = Get.put<OrderDetailsController>(
    OrderDetailsController(),
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                      employeeName: "?????? ????????????",
                      title: "",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (orderDetailsController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.8,
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
                                  TitleWidget(tilte: '???????????? ?????????????? ??????????????'),
                                  TextFieldCustom(
                                    enabled: false,
                                    hint: '?????? ????????????',
                                    textEditingController: orderDetailsController.clientNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldCustom(
                                    enabled: false,
                                    textEditingController: orderDetailsController.invoiceNumberController.value,
                                    hint: '?????? ????????????????',
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldCustom(
                                    enabled: false,
                                    hint: '?????? ??????????????',
                                    textEditingController: orderDetailsController.categoriesNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false, height: 158.h,

                                    //focusNode: focusNode,
                                    hint: '?????????? ????????????',
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
                                    hint: '???????????? ??????????????',
                                    onChanged: (val) {},
                                  ),
                                  if (orderDetailsController.boxNumberController.value.text != 'null')
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        TextFieldCustom(
                                          enabled: false,
                                          textEditingController: orderDetailsController.boxNumberController.value,
                                          hint: "?????? ????????????????",
                                          onChanged: (val) {},
                                        ),
                                      ],
                                    ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 30.h),
                                    child: MainButton(
                                      text: '????????',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        Get.back();
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
