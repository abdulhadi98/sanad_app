import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/driver/deliver_to_clients_controller.dart';
import 'package:wits_app/controller/incpection_officer/enter_box_number_controller.dart';
import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/controller/returns_manger/receive_returns_controller.dart';
import 'package:wits_app/helper/app_colors.dart';

import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class DeliverToClientScreen extends StatelessWidget {
  final put = Get.lazyPut<DeliverToClientController>(
    () => DeliverToClientController(),
  );
  final DeliverToClientController deliverToClientController = Get.find<DeliverToClientController>();
  final OrderDetailsController orderDetailsController = Get.find<OrderDetailsController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
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
                      title: "السائق",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (deliverToClientController.status!.value) {
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
                                    TitleWidget(tilte: orderDetailsController.orderDetailsModel!.clientName!),
                                    TextFieldTall(
                                      enabled: false, height: 158.h,
                                      //focusNode: focusNode,
                                      hint: 'عنوان العميل',
                                      textEditingController: orderDetailsController.addressController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 15.h,
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
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    deliverToClientController.selectedImage!.value.path != 'null'
                                        ? Obx(
                                            () => Container(
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
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: MainButton(
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
                                    ),
                                    SizedBox(
                                      height: 40.h,
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
