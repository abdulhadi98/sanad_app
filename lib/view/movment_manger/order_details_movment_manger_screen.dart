import 'dart:io';

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
import 'package:wits_app/model/order_details_model.dart';
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
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
                      title: "",
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
                                  OrderStatusWidget(
                                    color: orderDetailsController.orderDetailsModel!.statusColor!,
                                    statusName: orderDetailsController.orderDetailsModel!.statusName!,
                                  ),
                                  Container(
                                    //  color: Colors.red,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 34.0.w),
                                      child: Row(
                                        textDirection: ui.TextDirection.rtl,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 15.0.h),
                                            child: StepsIndicator(
                                              selectedStep: orderDetailsController.orderDetailsModel!.statusId! == 8 || orderDetailsController.orderDetailsModel!.statusId! == 5
                                                  ? 4
                                                  : orderDetailsController.orderDetailsModel!.statusId! - 1,
                                              nbSteps: 6,
                                              doneLineColor: Colors.green, //line
                                              doneStepColor: Colors.green,
                                              undoneLineColor: Color(0xFFE5E5E5), //line
                                              selectedStepColorIn: Colors.orange,

                                              selectedStepColorOut: Color(0xFFE5E5E5),
                                              unselectedStepColorIn: Colors.transparent,
                                              unselectedStepColorOut: Color(0xFFE5E5E5),

                                              //  undoneLineThickness: .5,
                                              isHorizontal: false,
                                              lineLength: 38.h,
                                              lineLengthCustomStep: [
                                                StepsIndicatorCustomLine(
                                                  nbStep: 1,
                                                  length: 40,
                                                )
                                              ],
                                              enableLineAnimation: true,
                                              enableStepAnimation: true,
                                            ),
                                          ),
                                          SizedBox(height: 270.h, width: 100.w, child: Processes(processesList: orderDetailsController.orderDetailsModel!.processes!)),
                                          Container(
                                            // color: Colors.red,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: List<Widget>.from(orderDetailsController.processesNamesList.map(
                                                  (e) => Padding(
                                                    padding: EdgeInsets.only(bottom: 15.0.h, left: 12.w, top: 8.h),
                                                    child: Text(
                                                      e, //TODO
                                                      textAlign: TextAlign.start,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 14.sp, fontWeight: FontWeight.w200),
                                                    ),
                                                  ),
                                                ))),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              //   DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 0),
                                              SizedBox(
                                                height: 29.h,
                                              ),
                                              SizedBox(
                                                height: 23.h,
                                              ),

                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              // DetailsButton(
                                              //     text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: orderDetailsController.orderDetailsModel!.statusId! > 1), //قيد التحضير
                                              SizedBox(
                                                height: 29.h,
                                              ),

                                              // DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 2),
                                              SizedBox(
                                                height: 29.h,
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              DetailsButton(
                                                  text: 'تفاصيل',
                                                  width: 76.w,
                                                  height: 29.h,
                                                  onPressed: () {
                                                    showDialogCustom(
                                                      height: height,
                                                      width: width,
                                                      context: context,
                                                      padding: EdgeInsets.zero,
                                                      dialogContent: StatefulBuilder(
                                                        builder: (context, setState) {
                                                          return Container(
                                                            padding: EdgeInsets.all(15.r),
                                                            color: AppColors.white,
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
                                                                  'صور السائقين',
                                                                  style: TextStyle(
                                                                    fontSize: 25.sp,
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

                                                                  width: width,
                                                                  child: Container(
                                                                    width: 305.w,
                                                                    height: orderDetailsController.orderDetailsModel!.truckImages!.length > 2 ? 300.h : 170.h,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(25.r),
                                                                        border: Border.all(
                                                                          color: AppColors.mainColor2,
                                                                        )),
                                                                    padding: EdgeInsets.all(25.r),
                                                                    alignment: Alignment.topCenter,
                                                                    child: GridView.builder(
                                                                        shrinkWrap: true,
                                                                        padding: EdgeInsets.zero,
                                                                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                                            maxCrossAxisExtent: 105.w, childAspectRatio: 1.05, crossAxisSpacing: 35.w, mainAxisSpacing: 20.h),
                                                                        itemCount: orderDetailsController.orderDetailsModel!.truckImages!.length,
                                                                        itemBuilder: (BuildContext ctx, index) {
                                                                          return Container(
                                                                            height: 91.h,
                                                                            width: 106.w,
                                                                            //  color: Colors.amber,
                                                                            child: Image.network(
                                                                              UrlsContainer.imagesUrl + '/' + orderDetailsController.orderDetailsModel!.truckImages![index].path!,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  isEnabeld: orderDetailsController.orderDetailsModel!.statusId! > 3), //قيد التسليم صور الشاحنة
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              SizedBox(
                                                height: 29.h,
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              DetailsButton(
                                                  text: 'تفاصيل',
                                                  width: 76.w,
                                                  height: 29.h,
                                                  onPressed: () {
                                                    showDialogCustom(
                                                      height: height,
                                                      width: width,
                                                      context: context,
                                                      padding: EdgeInsets.zero,
                                                      dialogContent: StatefulBuilder(
                                                        builder: (context, setState) {
                                                          return Container(
                                                            padding: EdgeInsets.all(15.r),
                                                            color: AppColors.white,
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
                                                                  'صورة الفاتورة المختومة',
                                                                  style: TextStyle(
                                                                    fontSize: 22.sp,
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
                                                                  width: 295.w,
                                                                  height: 220.h,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(25.r),
                                                                      border: Border.all(
                                                                        color: AppColors.mainColor2,
                                                                      )),
                                                                  padding: EdgeInsets.all(19.r),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10.r),
                                                                    child: Image.network(
                                                                      '${UrlsContainer.imagesUrl}\/${orderDetailsController.orderDetailsModel!.billImage!}',
                                                                      fit: BoxFit.contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  isEnabeld: (orderDetailsController.orderDetailsModel!.statusId! > 5 && orderDetailsController.orderDetailsModel!.statusId! != 8)), // تم التسليم
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
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
                                  if (orderDetailsController.boxNumberController.value.text != 'null')
                                    TextFieldCustom(
                                      enabled: false,
                                      textEditingController: orderDetailsController.boxNumberController.value,
                                      hint: "عدد الصناديق",
                                      onChanged: (val) {},
                                    ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  //
                                  if (orderDetailsController.orderDetailsModel!.truckImages!.length != 0)
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 295.w,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              ':صور السائقين',
                                              style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 305.w,
                                          height: orderDetailsController.orderDetailsModel!.truckImages!.length > 2 ? 300.h : 170.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25.r),
                                              border: Border.all(
                                                color: AppColors.mainColor2,
                                              )),
                                          padding: EdgeInsets.all(25.r),
                                          alignment: Alignment.topCenter,
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 105.w, childAspectRatio: 1.05, crossAxisSpacing: 35.w, mainAxisSpacing: 20.h),
                                              itemCount: orderDetailsController.orderDetailsModel!.truckImages!.length,
                                              itemBuilder: (BuildContext ctx, index) {
                                                return Container(
                                                  height: 91.h,
                                                  width: 106.w,
                                                  color: Colors.amber,
                                                  child: Image.network(
                                                    UrlsContainer.imagesUrl + '/' + orderDetailsController.orderDetailsModel!.truckImages![index].path!,
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  if (orderDetailsController.orderDetailsModel!.billImage != null)
                                    Column(
                                      children: [
                                        SizedBox(height: 15.h),
                                        SizedBox(
                                          width: 295.w,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              ':صورة الفاتورة المختومة',
                                              style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 295.w,
                                          height: 220.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25.r),
                                              border: Border.all(
                                                color: AppColors.mainColor2,
                                              )),
                                          padding: EdgeInsets.all(19.r),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.r),
                                            child: Image.network(
                                              '${UrlsContainer.imagesUrl}\/${orderDetailsController.orderDetailsModel!.billImage!}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30.h, top: 30.h),
                                    child: MainButton(
                                      text: 'عودة',
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

  Column DetailsButtons(int statusId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 4.h,
        ),
        //   DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 0),
        SizedBox(
          height: 29.h,
        ),
        SizedBox(
          height: 15.h,
        ),
        DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 1), //قيد التحضير
        SizedBox(
          height: 15.h,
        ),
        // DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 2),
        SizedBox(
          height: 29.h,
        ),
        SizedBox(
          height: 15.h,
        ),
        DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: statusId > 3), //قيد التسليم صور الشاحنة
        SizedBox(
          height: 15.h,
        ),
        DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: (statusId > 4 || statusId == 8)), // غير مختومة
        SizedBox(
          height: 15.h,
        ),
        DetailsButton(text: 'تفاصيل', width: 76.w, height: 29.h, onPressed: () {}, isEnabeld: (statusId > 5 && statusId != 8)), // تم التسليم
      ],
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    required this.statusName,
    required this.color,
  });

  final String color;
  final String statusName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22.0.h),
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
                color: Color(int.parse(color)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                statusName,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              )),
        ],
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
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
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
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        textDirection: ui.TextDirection.rtl,
        children: [
          SizedBox(
            width: 9.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //  alignment: Alignment.centerRight,
                //   width: 100.w,
                child: Text(
                  processCreateDate == null ? '' : Utils.formatProcessTime(processCreateDate!),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF798186), fontSize: 10.sp, fontWeight: FontWeight.w200),
                ),
              ),
              FutureBuilder<String>(
                future: Utils.formatProcessDate(processCreateDate ?? 'null'), // async work
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('');
                    default:
                      if (snapshot.hasError)
                        return Text('Error');
                      else
                        return Text(
                          snapshot.data!,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Color(0xFF798186), fontSize: 12.sp, fontWeight: FontWeight.w200),
                        );
                  }
                },
              )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  final String text;
  final bool isEnabeld;
  double? height;
  final double width;
  final Color? color;
  final Function() onPressed;
  DetailsButton({
    required this.isEnabeld,
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEnabeld
        ? SizedBox(
            width: width,
            height: height,
            child: MaterialButton(
              splashColor: color == null ? AppColors.mainColor2.withOpacity(0.5) : Colors.redAccent[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
              color: isEnabeld ? AppColors.mainColor1 : AppColors.gray,
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, letterSpacing: 0),
              ),
              textColor: Colors.white,
              onPressed: onPressed,
            ),
          )
        : SizedBox();
  }
}
