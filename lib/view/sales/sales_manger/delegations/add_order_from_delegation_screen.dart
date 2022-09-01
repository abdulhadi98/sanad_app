import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/textfield_search.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../../../common_wigets/bottom_nav_bar.dart';
import '../../../common_wigets/header_widget.dart';

class AddOrderFromDelegationScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //TextEditingController myController = TextEditingController();
  // final put = Get.put<DelegationDetailsController>(
  //   AddOrderFromDelegationScreenController(),
  // ); // or optionally with tag
  final DelegationDetailsScreenController delegationDetailsController = Get.find<DelegationDetailsScreenController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    //  globalController.scaffoldKey = scaffoldKey;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HeaderWidget(
                          width: width,
                          employeeName: "اسم الموظف",
                          title: "مدير قسم المبيعات",
                          scaffoldKey: scaffoldKey,
                        ),
                        Obx(() {
                          switch (delegationDetailsController.status!.value) {
                            case Status.LOADING:
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            case Status.ERROR:
                              return Utils.errorText();

                            case Status.DATA:
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container(
                                      height: 50.h,
                                      width: 295.w,
                                      child: TextFieldSearch(
                                        textStyle: TextStyle(
                                          color: AppColors.black.withOpacity(.70),
                                          fontSize: 13.sp,
                                        ),

                                        decoration: inputDecoration,
                                        // getSelectedValue: (b){print(b);},
                                        initialList: delegationDetailsController.clientsList.map((client) => client.clientNumber).toList(),
                                        label: delegationDetailsController.clientsList.isNotEmpty ? delegationDetailsController.clientsList.first.clientNumber! : ' ',
                                        controller: delegationDetailsController.clientNumberController.value,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.number,
                                    hint: 'أدخل رقم الفاتورة',
                                    textEditingController: delegationDetailsController.invoiceNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.number,
                                    hint: 'أدخل عدد الأصناف',
                                    textEditingController: delegationDetailsController.categoriesNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldTall(
                                    hint: 'تفاصيل إضافية',
                                    textEditingController: delegationDetailsController.detailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: MainButton(
                                      text: 'إرسال',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () {//TODO: salesmanger
                                        // AddOrderFromDelegationScreenController
                                        // if (delegationDetailsController.validateOrder()) {
                                        //   delegationDetailsController.setOrderModel();
                                        //   // print(delegationDetailsController.orderModel);
                                        //   Get.toNamed('/submit-order-delegation-screen');
                                        // }
                                      },
                                    ),
                                  ),
                                ],
                              );

                            default:
                              return Container();
                          }
                        })
                      ],
                    ),
                  ),
                ),

                //  if (WidgetsBinding.instance?.window.viewInsets.bottom! > 0.0)
                if (!isKeyboardShowing)
                  buildBottomNavBar(
                    width,
                    height,
                    false,
                    () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SalesMangerRootScreen()), (Route<dynamic> route) => false);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
