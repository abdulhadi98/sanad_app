import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/sales/add_delegation_controller.dart';
import 'package:wits_app/controller/sales/delegation_details_controller.dart';
import 'package:wits_app/controller/sales/delegations_controller.dart';
import 'package:wits_app/controller/sales/sales_employee_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/add_new_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/order_details_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../helper/enums.dart';
import '../../../common_wigets/bottom_nav_bar.dart';
import '../../../common_wigets/header_widget.dart';
import '../assign_salses_employee/worker_widget.dart';

class SalesmanOrderScreen extends StatelessWidget {
  static int? delegationId;
  SalesmanOrderScreen();

  final put = Get.put<DelegationDetailsScreenController>(
    DelegationDetailsScreenController(),
  ); // or optionally with tag
  final DelegationDetailsScreenController delegationDetailsScreenController = Get.find<DelegationDetailsScreenController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final salesEmp = Get.put<SalesEmployeeController>(
    SalesEmployeeController(),
  ); // or optionally with tag
  final SalesEmployeeController salesEmployeeController = Get.find<SalesEmployeeController>();
  //FocusNode focusNode = FocusNode();
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
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (delegationDetailsScreenController.status!.value) {
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
                                    TitleWidget(tilte: '“ ${delegationDetailsScreenController.employeeName.value} ”'),
                                    TextFieldCustom(
                                      textEditingController: delegationDetailsScreenController.clientNumberController.value,
                                      enabled: false,
                                      hint: 'رقم العميل',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    TextFieldTall(
                                      textEditingController: delegationDetailsScreenController.detailsController.value,
                                      enabled: false,
                                      height: 158.h,
                                      hint: 'تفاصيل إضافية',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    MainButton(
                                      text: 'قبول و إضافة',
                                      color: AppColors.mainColor1,
                                      width: 262.w,
                                      height: 50.h,
                                      onPressed: () {
                                        Get.toNamed('/add-order-from-delegation-screen');
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    MainButton(
                                      text: 'قبول و تعيين موظف مبيعات',
                                      color: AppColors.mainColor1,
                                      width: 262.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        await salesEmployeeController.getSalesEmployees();
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
                                                            child: Padding(
                            padding: EdgeInsets.only(bottom: 15.0.h, left: 15.w, top: 20.w, right: 15.w),
                                                              child: SvgPicture.asset(
                                                                'assets/icons/Icon Close Light-1.svg',
                                                                width: 16.w,
                                                                height: 16.w,
                                                              ),
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
                                                          itemCount: salesEmployeeController.salesEmployeesList.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return WorkerWidget(
                                                                imageUrl: salesEmployeeController.salesEmployeesList[index].imagePorofile ?? 'assets/images/worker1.png',
                                                                workerName: salesEmployeeController.salesEmployeesList[index].name!,
                                                                workerDepartment: 'قسم المبيعات',
                                                                onPressed: () {
                                                                  salesEmployeeController.employeeId = salesEmployeeController.salesEmployeesList[index].id;

                                                                  print(salesEmployeeController.employeeId);
                                                                  Get.back();
                                                                  Get.toNamed('/accept-and-assign-sales-employee',
                                                                      arguments: {'sales_employee_id': salesEmployeeController.salesEmployeesList[index].id});
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
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    MainButton(
                                      text: 'رفض /\ طلب تعديل',
                                      color: AppColors.mainColor1,
                                      width: 262.w,
                                      height: 50.h,
                                      onPressed: () {
                                        Get.toNamed('/reject-delegation-screen', arguments: {'delegation_id': Get.arguments['delegation_id']});
                                      },
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
