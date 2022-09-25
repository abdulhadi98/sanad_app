import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/controller/warehouse_manger/assign_preperator_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/model/order_details_model.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../helper/enums.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';
import 'dart:ui' as ui;

class AssignPreperatorScreen extends StatelessWidget {
  final put = Get.put<PerperatorController>(
    PerperatorController(),
  );
  final PerperatorController perperatorController = Get.find<PerperatorController>();

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
                      title: "مدير المستودع",
                      scaffoldKey: scaffoldKey,
                    ),
                    //      TitleWidget(tilte: 'تفاصيل الطلبية الجديدة'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (orderDetailsController.status!.value == Status.LOADING || perperatorController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (orderDetailsController.status!.value == Status.ERROR || perperatorController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
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
                                  // SizedBox(
                                  //   height: 12.h,
                                  // ),
                                  // TextFieldCustom(
                                  //   enabled: false,
                                  //   textEditingController: orderDetailsController.boxNumberController.value,
                                  //   hint: "عدد الصناديق",
                                  //   onChanged: (val) {},
                                  // ),

                                  if (perperatorController.preparatorId != null)
                                    WorkerName(name: perperatorController.preparatorsList.firstWhere((element) => element.id == perperatorController.preparatorId).name!),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: MainButton(
                                      text: 'تعيين عامل التحضير',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        await perperatorController.getPreparators();
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
                                                      'تعيين  عامل تحضير',
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
                                                          itemCount: perperatorController.preparatorsList.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return WorkerWidget(
                                                  imageUrl: perperatorController.preparatorsList[index].imagePorofile ?? 'assets/images/worker1.png',

                                                                workerName: perperatorController.preparatorsList[index].name!,
                                                                workerDepartment: 'قسم التحضير',
                                                                onPressed: () {
                                                                  perperatorController.preparatorId = perperatorController.preparatorsList[index].id;
                                                                  print(perperatorController.preparatorId);

                                                                  perperatorController.setStatus(Status.LOADING);
                                                                  perperatorController.setStatus(Status.DATA);

                                                                  Get.back();
                                                                  // Get.toNamed(
                                                                  //     '/send_order_to_sales_employee');
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
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30.h),
                                    child: MainButton(
                                      text: 'إرسال',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        if (perperatorController.preparatorId == null)
                                          Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تعيين عامل تحضير', toastColor: AppColors.red);
                                        else
                                          await perperatorController.assignPerperator();
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

class Processes extends StatelessWidget {
  Processes({this.processesList});
  final List<Process>? processesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: processesList!.length,
        shrinkWrap: true,
        itemBuilder: (builder, index) {
          return ProcessWidget(
            processName: processesList![index].statusName!,
            processCreateDate: processesList![index].createdAt == null ? null : processesList![index].createdAt!.toLocal(),
          );
        });
  }
}

class ProcessWidget extends StatelessWidget {
  ProcessWidget({this.onDetailsPressed, this.processCreateDate, required this.processName});
  final String processName;
  final DateTime? processCreateDate;
  final Function? onDetailsPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      textDirection: ui.TextDirection.rtl,
      children: [
        Column(
          children: [
            Text(
              processCreateDate == null ? '' : Utils.formatProcessTime(processCreateDate!),
              textAlign: TextAlign.start,
            ),
            FutureBuilder<String>(
              future: Utils.formatProcessDate(processCreateDate ?? 'null'), // async work
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading....');
                  default:
                    if (snapshot.hasError)
                      return Text('Error');
                    else
                      return Text(snapshot.data!);
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
