import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:wits_app/controller/driver/deliver_to_clients_controller.dart';
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

class ReciveFromAnotherDriver extends StatelessWidget {
  final orderDetailsController = Get.put<OrderDetailsController>(
    OrderDetailsController(),
  );
  final DeliverToClientController deliverToClientController = Get.put<DeliverToClientController>(
    DeliverToClientController(),
  );
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
                    TitleWidget(tilte: 'تفاصيل الحمولة'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (orderDetailsController.status!.value == Status.LOADING || deliverToClientController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (orderDetailsController.status!.value == Status.ERROR || deliverToClientController.status!.value == Status.ERROR)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
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
                                  MainButton(
                                    text: 'اذهب إلى خرائط جوجل',
                                    width: 295.w,
                                    height: 50.h,
                                    onPressed: () async {
                                      await Utils.openMap(
                                        double.parse(
                                          orderDetailsController.orderDetailsModel!.clientLatitude!,
                                        ),
                                        double.parse(orderDetailsController.orderDetailsModel!.clientLatitude!),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 25.h,
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
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10.w),
                                    width: 295.w,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        ':ختم العميل',
                                        style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialogCustom(
                                          context: context,
                                          padding: EdgeInsets.zero,
                                          dialogContent: DialogContentSingleImage(path: orderDetailsController.orderDetailsModel!.clientStamp!),
                                          height: height,
                                          width: width);
                                    },
                                    child: Container(
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
                                          '${UrlsContainer.imagesUrl}\/${orderDetailsController.orderDetailsModel!.clientStamp!}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  MainButton(
                                    text: 'تصوير الفاتورة المختومة',
                                    width: 295.w,
                                    height: 50.h,
                                    onPressed: () async {
                                      deliverToClientController.pickImage();
                                    },
                                  ),
                                  if (deliverToClientController.selectedImage!.value.path != 'null')
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Container(
                                          width: 243.w,
                                          height: 220.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25.r),
                                              border: Border.all(
                                                color: AppColors.mainColor2,
                                              )),
                                          padding: EdgeInsets.all(19.r),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.r),
                                            child: Image.file(
                                              deliverToClientController.selectedImage!.value,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  if (deliverToClientController.selectedImage!.value.path == 'null') //if we add an image then the not stamped bill button snhould be hidden
                                    MainButton(
                                      text: 'الفاتورة غير مختومة',
                                      color: AppColors.red,
                                      width: 295.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        dynamic status = await deliverToClientController.orderNotStamped();
                                        if (status == '200')
                                          showDialogCustom(
                                            height: height,
                                            width: width,
                                            context: context,
                                            padding: EdgeInsets.zero,
                                            dialogContent: DialogContentThanks(
                                              onTap: () {
                                                Get.offAllNamed('/driver-root-screen');
                                              },
                                            ),
                                          );
                                      },
                                    ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 30.0.h),
                                    child: MainButton(
                                        text: 'إرسال',
                                        width: 178.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          if (deliverToClientController.selectedImage!.value.path == 'null') {
                                            Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تصوير الفاتورة قبل الإرسال', toastColor: AppColors.red);
                                            return;
                                          }
                                          var uploadImageStatus = await deliverToClientController.uploadBillImage();

                                          if (uploadImageStatus == '200') {
                                            var stampedStatus = await deliverToClientController.orderIsStamped();
                                            if (stampedStatus == '200') {
                                              showDialogCustom(
                                                height: height,
                                                width: width,
                                                context: context,
                                                padding: EdgeInsets.zero,
                                                dialogContent: DialogContentThanks(
                                                  onTap: () {
                                                    Get.offAllNamed('/driver-root-screen');
                                                  },
                                                ),
                                              );
                                            }
                                          }
                                        }),
                                  )
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
