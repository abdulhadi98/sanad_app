import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wits_app/controller/general_manager/add_review_by_order_controller.dart';
import 'package:wits_app/controller/general_manager/review_by_department_controller.dart';

import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/RoleWidget.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';

import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/order_widget.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/textfield_search.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../../controller/global_controller.dart';
import '../../helper/enums.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class ReviewByDepartmentSuperManagerScreen extends StatelessWidget {
  final ReviewByDepartmentController reviewByDepartmentController = Get.put<ReviewByDepartmentController>(
    ReviewByDepartmentController(),
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                      title: "مسؤول التحكم",
                      scaffoldKey: scaffoldKey,
                    ),
                    TitleWidget(tilte: 'أضف ملاحظة'),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (reviewByDepartmentController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (reviewByDepartmentController.status!.value == Status.ERROR)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
                                  MainButton(
                                    text: 'اختر القسم',
                                    width: 295.w,
                                    height: 50.h,
                                    onPressed: () async {
                                      FocusScope.of(context).requestFocus(FocusNode());

                                      //  reviewByDepartmentController.getOrderId(reviewByDepartmentController.invoiceNumberController.value.text);

                                      //    await reviewByDepartmentController.getDepartments();

                                      //    await driversController.getDrivers();
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
                                                    'اختر قسم',
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
                                                        itemCount: reviewByDepartmentController.rolesList.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return RoleWidget(
                                                            roleName: reviewByDepartmentController.rolesList[index].role,
                                                            onTap: () {
                                                              reviewByDepartmentController.roleId = reviewByDepartmentController.rolesList[index].id;
                                                              Get.back();
                                                            },
                                                          );
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
                                    height: 20.h,
                                  ),
                                  MainButtonWithIcon(
                                    icon: Icons.person,
                                    loadingLocation: reviewByDepartmentController.employeesSpinner.value,
                                    text: 'اختر موظف',
                                    width: 295.w,
                                    height: 50.h,
                                    onPressed: () async {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (reviewByDepartmentController.roleId == null) {
                                        Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار القسم', toastColor: AppColors.red);
                                        return;
                                      }

                                      await reviewByDepartmentController.getEmployeesByDepartment();

                                      //    await driversController.getDrivers();
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
                                                    'اختر موظفاً',
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
                                                        itemCount: reviewByDepartmentController.employeeList.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return WorkerWidget(
                                                              imageUrl: reviewByDepartmentController.employeeList[index].imagePorofile ?? 'assets/images/worker1.png',
                                                              workerName: reviewByDepartmentController.employeeList[index].name!,
                                                              workerDepartment: '',
                                                              onPressed: () {
                                                                reviewByDepartmentController.employeeId = reviewByDepartmentController.employeeList[index].id;
                                                                //  SalesMangerRootScreen.salesmanId = driversController.driversList[index].id;
                                                                print(reviewByDepartmentController.employeeId);
                                                                Get.back();
                                                                // Get.toNamed(
                                                                //     '/send_order_to_sales_employee');
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
                                    height: 20.h,
                                  ),
                                  TextFieldTall(
                                    hint: 'أضف الملاحظة',
                                    onChanged: (val) {},
                                    textEditingController: reviewByDepartmentController.reviewController.value,
                                  ),
                                  SizedBox(
                                    height: 90.h,
                                  ),
                                  MainButton(
                                      text: 'إرسال',
                                      width: 178.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        if (reviewByDepartmentController.validate()) {
                                          var addReturnsStatus = await reviewByDepartmentController.addReview();
                                          if (addReturnsStatus == '200')
                                            showDialogCustom(
                                              height: height,
                                              width: width,
                                              context: context,
                                              padding: EdgeInsets.zero,
                                              dialogContent: DialogContentThanks(
                                                onTap: () {
                                                  Get.offAllNamed('/choose-warehouse-screen');
                                                },
                                              ),
                                            );
                                         }
                                      }),
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
