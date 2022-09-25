import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/sales_employee/delegation_details_sales_employee_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/get_delegation_details_and_add_order_from_delegation_controllrer.dart';
import 'package:wits_app/controller/sales/sales_man/rejected_delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/add_order_from_delegation_screen_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
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
                          employeeName: "اسم الموظف",
                          title: "مندوب المبيعات",
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
                                    hint: 'رقم العميل',
                                    textEditingController: rejectDelegationDetailsController.clientNumberController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  //Text(nullVal!),

                                  TextFieldTall(
                                    enabled: false,
                                    hint: 'تفاصيل إضافية',
                                    textEditingController: rejectDelegationDetailsController.detailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  TextFieldTall(
                                    enabled: false,
                                    hint: 'تفاصيل الرفض',
                                    textEditingController: rejectDelegationDetailsController.rejectDetailsController.value,
                                    onChanged: (val) {},
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: MainButton(
                                      text: 'عودة',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () {
                                        Get.back();
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
