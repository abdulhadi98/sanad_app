import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/add_delegation_controller.dart';
import 'package:wits_app/controller/sales/delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_employee_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/add_delegation_salesmanger_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/bottom_nav_bar.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/header_widget.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/textfield_search.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../helper/enums.dart';
import '../../../../helper/utils.dart';

class SendOrderToSalesEmployee extends StatelessWidget {
  SendOrderToSalesEmployee({Key? key}) : super(key: key);
  // or optionally with tag

  final put = Get.put<AddDelegationSalesMangerController>(
    AddDelegationSalesMangerController(),
  ); // or optionally with tag
  final AddDelegationSalesMangerController addDelegationSalesMangerController = Get.find<AddDelegationSalesMangerController>();
  final SalesEmployeeController salesEmployeeController = Get.find<SalesEmployeeController>();

  final put2 = Get.put<AddDelegationController>(
    AddDelegationController(),
  );
  final AddDelegationController addDelegationController = Get.find<AddDelegationController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.mainColor1,
    //   statusBarBrightness: Brightness.dark,
    // ));
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
                    TitleWidget(tilte: 'تفاصيل الطلب'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (addDelegationSalesMangerController.status!.value) {
                              case Status.LOADING:
                                return SizedBox(
                                  height: height / 2,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              case Status.ERROR:
                                return Utils.errorText();

                              case Status.DATA:
                                return Column(
                                  children: [
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
                                          initialList: addDelegationSalesMangerController.clientsList.map((client) => client.clientNumber).toList(),
                                          label: addDelegationSalesMangerController.clientsList.isNotEmpty ? addDelegationSalesMangerController.clientsList.first.clientNumber! : ' ',
                                          controller: addDelegationSalesMangerController.clientNumberController.value,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    TextFieldTall(
                                      //    enabled: false,
                                      height: 158.h,
                                      textEditingController: addDelegationSalesMangerController.detailsController.value,

                                      hint: 'تفاصيل إضافية',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    MainButton(
                                      text: 'إرسال',
                                      color: AppColors.mainColor1,
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                          FocusScope.of(context).requestFocus(FocusNode());

                                        // addNewOrderScreenController
                                        if (addDelegationSalesMangerController.validateInputs()) {
                                          //if all fields not empty

                                          showDialogCustom(
                                            height: height,
                                            width: width,
                                            context: context,
                                            padding: EdgeInsets.zero,
                                            dialogContent: DialogContentAreYouSure(
                                              onYes: () async {
                                                
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                addDelegationSalesMangerController.setDelegationManger(
                                                  Get.arguments['sales_employee_id'],
                                                );
                                                // addDelegationController
                                                //         .setDelegationInfo()
                                                dynamic status = await addDelegationSalesMangerController.addDelegationManger();
                                                if (status == '200')
                                                  showDialogCustom(
                                                      height: height,
                                                      width: width,
                                                      context: context,
                                                      padding: EdgeInsets.zero,
                                                      dialogContent: DialogContentThanks(onTap: () {
                                                        Get.offAllNamed('/sales_manger_root_screen');
                                                      }));
                                              },
                                            ),
                                          );
                                        }
                                      },
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
