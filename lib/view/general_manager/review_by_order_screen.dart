import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wits_app/controller/general_manager/add_review_by_order_controller.dart';

import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
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

class ReviewByOrderScreen extends StatelessWidget {
  final ReviewByOrderController reviewByOrderController = Get.put<ReviewByOrderController>(
    ReviewByOrderController(),
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
                      title: "المدير العام",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            if (reviewByOrderController.status!.value == Status.LOADING)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else if (reviewByOrderController.status!.value == Status.ERROR)
                              return SizedBox(
                                height: height / 1.5,
                                child: Center(
                                  child: Utils.errorText(),
                                ),
                              );
                            else
                              return Column(
                                children: [
                                  TitleWidget(tilte: 'إضافة ملاحظة'),
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
                                        decoration: enabledK('اختر رقم الفاتورة'),
                                        // getSelectedValue: (b){print(b);},

                                        initialList: reviewByOrderController.ordersList.map((order) => order.invoiceNumber).toList(),
                                        label: reviewByOrderController.ordersList.isNotEmpty ? reviewByOrderController.ordersList.first.invoiceNumber! : ' ',
                                        controller: reviewByOrderController.invoiceNumberController.value,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  MainButtonWithIcon(
                                    icon: Icons.person,
                                    loadingLocation: reviewByOrderController.employeesSpinner.value,
                                    text: 'اختر موظف',
                                    width: 295.w,
                                    height: 50.h,
                                    onPressed: () async {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (reviewByOrderController.invoiceNumberController.value.text.isEmpty) {
                                        Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار رقم الفاتورة', toastColor: AppColors.red);
                                        return;
                                      }

                                      reviewByOrderController.getOrderId(reviewByOrderController.invoiceNumberController.value.text);

                                      await reviewByOrderController.getEmployeesByOrder();

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
                                                        itemCount: reviewByOrderController.employeeList.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          return WorkerWidget(
                                                              imageUrl: reviewByOrderController.employeeList[index].imagePorofile ?? 'assets/images/worker1.png',
                                                              workerName: reviewByOrderController.employeeList[index].name!,
                                                              workerDepartment: '',
                                                              onPressed: () {
                                                                reviewByOrderController.employeeId = reviewByOrderController.employeeList[index].id;
                                                                //  SalesMangerRootScreen.salesmanId = driversController.driversList[index].id;
                                                                print(reviewByOrderController.employeeId);
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
                                    textEditingController: reviewByOrderController.reviewController.value,
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
                                        if (reviewByOrderController.validate()) {
                                          var addReturnsStatus = await reviewByOrderController.addReview();
                                          if (addReturnsStatus == '200')
                                            showDialogCustom(
                                              height: height,
                                              width: width,
                                              context: context,
                                              padding: EdgeInsets.zero,
                                              dialogContent: DialogContentThanks(
                                                onTap: () {
                                                  Get.offAllNamed('/general-manager-root-screen');
                                                },
                                              ),
                                            );
                                          // }

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
