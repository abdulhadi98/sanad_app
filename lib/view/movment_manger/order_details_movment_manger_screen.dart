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

class OrderDetailsMovmentMangerScreen extends StatelessWidget {
  OrderDetailsMovmentMangerScreen({Key? key}) : super(key: key);
  final put = Get.put<DriversController>(
    DriversController(),
  );
  final DriversController driversController = Get.find<DriversController>();

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
                      title: "مدير قسم المبيعات",
                      scaffoldKey: scaffoldKey,
                    ),
                    //      TitleWidget(tilte: 'تفاصيل الطلبية الجديدة'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (orderDetailsController.status!.value == Status.LOADING || driversController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (orderDetailsController.status!.value == Status.ERROR || driversController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      await initializeDateFormatting("ar_SA", '');
                                      var now = orderDetailsController.orderDetailsModel!.processes!.first.createdAt;
                                      //    print(Utils.convertToArabicNumber(now!.hour.toString()));
                                      var formatter = DateFormat.yMMMMd('ar_SA');
                                      var formatterTime = DateFormat.HOUR24_MINUTE_SECOND;
                                      //print(formatter.locale);
                                      String formatted = formatter.format(now!);
                                      // print(formatted);

                                      //        print(now.toLocal());

                                      var d = DateFormat('hh:mm a').format(now);
                                      //  print(d);

                                      var x = Utils.formatProcessTime(now);
                                    },
                                    child: Text('adsa'),
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18.0.h),
                                    child: Row(
                                      textDirection: ui.TextDirection.rtl,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ":حالة الطلبية",
                                          style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: ('Bahij')),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            width: 174.w,
                                            height: 29.h,
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(orderDetailsController.orderDetailsModel!.statusColor!)),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Text(
                                              orderDetailsController.orderDetailsModel!.statusName!,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    textDirection: ui.TextDirection.rtl,
                                    children: [
                                      StepsIndicator(
                                        selectedStep: orderDetailsController.orderDetailsModel!.statusId! == 8 || orderDetailsController.orderDetailsModel!.statusId! == 5
                                            ? 4
                                            : orderDetailsController.orderDetailsModel!.statusId! - 1,
                                        nbSteps: 7,
                                        doneLineColor: Colors.green, //line
                                        doneStepColor: Colors.green,
                                        undoneLineColor: Color(0xFFE5E5E5), //line
                                        selectedStepColorIn: Colors.orange,
                                        selectedStepColorOut: Color(0xFFE5E5E5),
                                        unselectedStepColorIn: Colors.transparent,
                                        unselectedStepColorOut: Color(0xFFE5E5E5),

                                        //  undoneLineThickness: .5,
                                        isHorizontal: false,
                                        lineLength: 20,
                                        lineLengthCustomStep: [
                                          StepsIndicatorCustomLine(
                                            nbStep: 1,
                                            length: 40,
                                          )
                                        ],
                                        enableLineAnimation: true,
                                        enableStepAnimation: true,
                                      ),
                                      SizedBox(height: 310.h, width: width / 1.5, child: Processes(processesList: orderDetailsController.orderDetailsModel!.processes!)),
                                    ],
                                  ),
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
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: MainButton(
                                      text: 'تعيين السائق',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        await driversController.getDrivers();
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
                                                      'تعيين موظف المبيعات',
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
                                                          itemCount: driversController.driversList.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return WorkerWidget(
                                                                workerName: driversController.driversList[index].name!,
                                                                workerDepartment: 'قسم المبيعات',
                                                                onPressed: () {
                                                                  driversController.driverId = driversController.driversList[index].id;
                                                                  //  SalesMangerRootScreen.salesmanId = driversController.driversList[index].id;
                                                                  print(driversController.driverId);
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
                                        if (driversController.driverId == null)
                                          Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تعيين سائق', toastColor: AppColors.red);
                                        else
                                          await driversController.assignDriver();
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
