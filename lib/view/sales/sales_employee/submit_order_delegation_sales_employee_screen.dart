import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/get_delegation_details_and_add_order_from_delegation_controllrer.dart';
import 'package:wits_app/controller/sales/sales_manger/add_order_from_delegation_screen_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_employee/add_order_from_delegation_sales_employee_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/header_widget.dart';

class SubmitOrderDelegationSalesEmployeeScreen extends StatelessWidget {
  final GetDelegationAndAddNewOrderFromDelegationScreenController addOrderController = Get.find<GetDelegationAndAddNewOrderFromDelegationScreenController>();

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
                    // TitleWidget(tilte: 'تفاصيل الطلبية الجديدة'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (addOrderController.status!.value) {
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
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'رقم العميل',
                                      textEditingController: addOrderController.clientNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      textEditingController: addOrderController.invoiceNumberController.value,
                                      hint: 'رقم الفاتورة',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'عدد الأصناف',
                                      textEditingController: addOrderController.categoriesNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false, height: 158.h,

                                      //focusNode: focusNode,
                                      hint: 'عنوان العميل',
                                      textEditingController: addOrderController.addressController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false,
                                      height: 158.h,
                                      textEditingController: addOrderController.detailsController.value,
                                      hint: 'تفاصيل إضافية',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    MainButton(
                                      text: 'تعديل',
                                      color: AppColors.red,
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                 
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: MainButton(
                                        text: 'إرسال',
                                        width: 178.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          FocusScope.of(context).requestFocus(FocusNode());

                                          dynamic addStatus = await addOrderController.addNewOrder();
                                          // if (status == '777')
                                          //   Utils.showGetXToast(
                                          //       message: status);
                                          if (addStatus == '200') {
                                            dynamic status = await addOrderController.addOrderIdToDelegation();
                                            if (status == '200')
                                              showDialogCustom(
                                                height: height,
                                                width: width,
                                                context: context,
                                                padding: EdgeInsets.zero,
                                                dialogContent: DialogContentThanks(
                                                  onTap: () {
                                                    Get.offAllNamed('/sales-employee-root-screen');
                                                  },
                                                ),
                                              );
                                          }
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
