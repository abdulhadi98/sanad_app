import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/add_order_from_delegation_controller.dart';
import 'package:wits_app/controller/sales/delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/add_order_from_delegation_screen_controller.dart';
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
  final put = Get.put<AddNewOrderFromDelegationScreenController>(
    AddNewOrderFromDelegationScreenController(),
  ); // or optionally with tag
  final AddNewOrderFromDelegationScreenController addNewOrderFromDelegationScreenController = Get.find<AddNewOrderFromDelegationScreenController>();

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
                          employeeName: "?????? ????????????",
                          title: "???????? ?????? ????????????????",
                          scaffoldKey: scaffoldKey,
                        ),
                        Obx(() {
                          switch (addNewOrderFromDelegationScreenController.status!.value) {
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
                                    hint: '???????? ?????? ????????????',
                                    textEditingController: delegationDetailsController.clientNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  //Text(nullVal!),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.number,
                                    hint: '???????? ?????? ????????????????',
                                    textEditingController: addNewOrderFromDelegationScreenController.invoiceNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.number,
                                    hint: '???????? ?????? ??????????????',
                                    textEditingController: addNewOrderFromDelegationScreenController.categoriesNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false,
                                    hint: '???????????? ????????????',
                                    textEditingController: delegationDetailsController.detailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: MainButton(
                                      text: '??????????',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () {
                                        if (addNewOrderFromDelegationScreenController.validateInputs()) {
                                          addNewOrderFromDelegationScreenController.setOrderModel(
                                            details: delegationDetailsController.detailsController.value.text,
                                            clientNumber: delegationDetailsController.clientNumberController.value.text,
                                            salesmanId: delegationDetailsController.delegationModel!.creatorId!,
                                          );
                                          // print(delegationDetailsController.orderModel);
                                          Get.toNamed('/submit-order-delegation-screen', arguments: {'delegation_id': delegationDetailsController.delegationModel!.id});
                                        }
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
