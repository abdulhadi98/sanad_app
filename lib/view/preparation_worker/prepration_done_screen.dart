import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/movment_manger/print_order_movment_manger_controller.dart';
import 'package:wits_app/controller/prepration_worker/prepration_done_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/add_new_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../../../controller/sales/add_new_order_screen_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class PrepartionDoneSceeen extends StatelessWidget {
  PrepartionDoneSceeen({Key? key}) : super(key: key);

  var put = Get.lazyPut<PerpartionWorkerController>(
    () => PerpartionWorkerController(),
  );
  final PerpartionWorkerController perpartionWorkerController = Get.find<PerpartionWorkerController>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalController globalController = Get.find<GlobalController>();

//  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                      title: "عامل التحضير",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (perpartionWorkerController.status!.value) {
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
                                return Column(
                                  children: [
                                    TitleWidget(tilte: 'تفاصيل الطلبية الجديدة'),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'رقم العميل',
                                      textEditingController: perpartionWorkerController.clientNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      textEditingController: perpartionWorkerController.invoiceNumberController.value,
                                      hint: 'رقم الفاتورة',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'عدد الأصناف',
                                      textEditingController: perpartionWorkerController.categoriesNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false, height: 158.h,

                                      //focusNode: focusNode,
                                      hint: 'عنوان العميل',
                                      textEditingController: perpartionWorkerController.addressController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false,
                                      height: 158.h,
                                      textEditingController: perpartionWorkerController.detailsController.value,
                                      hint: 'تفاصيل إضافية',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: MainButton(
                                        text: 'تمت الطباعة',
                                        width: 178.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          dynamic status = await perpartionWorkerController.prepartionDone();
                                          // if (status == '777')
                                          //   Utils.showGetXToast(
                                          //       message: status);
                                          if (status == '200')
                                            showDialogCustom(
                                              height: height,
                                              width: width,
                                              context: context,
                                              padding: EdgeInsets.zero,
                                              dialogContent: DialogContentThanks(
                                                onTap: () {
                                                  Get.offAllNamed('/prepartion-worker-root-screen');
                                                },
                                              ),
                                            );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                            }
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