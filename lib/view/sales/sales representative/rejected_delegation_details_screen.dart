import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/sales_employee/delegation_details_sales_employee_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/get_delegation_details_and_add_order_from_delegation_controllrer.dart';
import 'package:wits_app/controller/sales/sales_man/rejected_delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/add_order_from_delegation_screen_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../../common_wigets/bottom_nav_bar.dart';
import '../../common_wigets/header_widget.dart';

class RejectedDelegationDetailsScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //TextEditingController myController = TextEditingController();
  final RejectDelegationDetailsController rejectDelegationDetailsController = Get.put<RejectDelegationDetailsController>(
    RejectDelegationDetailsController(),
  ); // or optionally with tag

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
                          employeeName: "?????? ????????????",
                          title: "?????????? ????????????????",
                          scaffoldKey: scaffoldKey,
                        ),
                        Obx(() {
                          switch (rejectDelegationDetailsController.status!.value) {
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
                                  TextFieldCustom(
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                    hint: '?????? ????????????',
                                    textEditingController: rejectDelegationDetailsController.clientNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  //Text(nullVal!),

                                  TextFieldTall(
                                    enabled: false,
                                    hint: '???????????? ????????????',
                                    textEditingController: rejectDelegationDetailsController.detailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false,
                                    hint: '???????????? ??????????',
                                    textEditingController: rejectDelegationDetailsController.rejectDetailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  MainButton(
                                    text: '?????????? ??????????????',
                                    width: 178.w,
                                    height: 50.h,
                                    color: AppColors.red,
                                    onPressed: () async {
                                      showDialogCustom(
                                        height: height,
                                        width: width,
                                        context: context,
                                        padding: EdgeInsets.zero,
                                        dialogContent: DialogContentAreYouSure(
                                          onYes: () async {
                                            dynamic status = await rejectDelegationDetailsController.deleteDelegation();
                                            if (status == '200')
                                              showDialogCustom(
                                                height: height,
                                                width: width,
                                                context: context,
                                                padding: EdgeInsets.zero,
                                                dialogContent: DialogContentThanks(
                                                  onTap: () {
                                                    Get.offAllNamed('/salesman-root-screen-new');
                                                  },
                                                ),
                                              );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  MainButton(
                                    text: '?????????? ??????????????',
                                    width: 178.w,
                                    height: 50.h,
                                    color: AppColors.mainColor1,
                                    onPressed: () async {
                                      Get.toNamed('/resend-delegation-screen', arguments: {'delegation_id': Get.arguments['delegation_id']});
                                    },
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
