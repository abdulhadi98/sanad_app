import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/driver/add_returns_controller.dart';
import 'package:wits_app/controller/driver/deliver_to_clients_controller.dart';
import 'package:wits_app/controller/driver/deliver_to_driver_controller.dart';
import 'package:wits_app/controller/incpection_officer/enter_box_number_controller.dart';
import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/controller/returns_manger/receive_returns_controller.dart';
import 'package:wits_app/helper/app_colors.dart';

import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/textfield_search.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';
import 'package:geolocator/geolocator.dart';

class AddReturnsAfterDeliverScreen extends StatelessWidget {
  final AddReturnsController addReturnsController = Get.put<AddReturnsController>(
    AddReturnsController(),
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalController globalController = Get.find<GlobalController>();
  //Future<bool> _onBackPressed()

//  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return WillPopScope(
      onWillPop: () async {
        return (showDialogCustom(
              height: height,
              width: width,
              context: context,
              padding: EdgeInsets.zero,
              dialogContent: DialogContentAreYouSure(
                onYes: () async {
                  Get.offAllNamed('/driver-root-screen');
                },
              ),
            )) ??
            false;
      },
      child: Scaffold(
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
                              switch (addReturnsController.status!.value) {
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
                                      TitleWidget(tilte: "تفاصيل المرتجعات"),

                                      TextFieldCustom(
                                        enabled: false,
                                        hint: '',
                                        textEditingController: addReturnsController.clientNumberController.value,
                                        onChanged: (val) {},
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      TextFieldTall(
                                        hint: 'تفاصيل المرتجعات',
                                        textEditingController: addReturnsController.returnsDetailsController.value,
                                        onChanged: (val) {},
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      TextFieldCustom(
                                        // enabled: false,
                                        textEditingController: addReturnsController.invoiceNumberController.value,
                                        keyboardType: TextInputType.number,
                                        hint: 'رقم فاتورة المرتجعات',
                                        onChanged: (val) {},
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      MainButton(
                                        text: 'تصوير فاتورة المرتجعات',
                                        width: 295.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          // await showDialog(
                                          //         // Your Dialog Code
                                          //         )
                                          //     .then((val) {
                                          //   Navigator.pop(_context);
                                          // });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      MainButton(
                                        text: 'تصوير فاتورة المرتجعات',
                                        width: 295.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          addReturnsController.pickReturnImage();
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      addReturnsController.selectedImage!.value.path != 'null'
                                          ? Obx(
                                              () => Padding(
                                                padding: EdgeInsets.only(bottom: 15.h),
                                                child: Container(
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
                                                      addReturnsController.selectedImage!.value,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      MainButton(
                                        text: addReturnsController.selectedImages.length == 0 ? 'تصوير المرتجعات' : 'إضافة صور أخرى',
                                        width: 295.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          FocusScope.of(context).requestFocus(FocusNode());

                                          addReturnsController.pickImage();
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      addReturnsController.selectedImages.length != 0
                                          ? Container(
                                              width: 295.w,
                                              height: 300.h,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(25.r),
                                                  border: Border.all(
                                                    color: AppColors.mainColor2,
                                                  )),
                                              padding: EdgeInsets.all(25.r),
                                              alignment: Alignment.topCenter,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 105.w, childAspectRatio: 1.05, crossAxisSpacing: 35.w, mainAxisSpacing: 20.h),
                                                  itemCount: addReturnsController.selectedImages.length,
                                                  itemBuilder: (BuildContext ctx, index) {
                                                    return Container(
                                                      height: 91.h,
                                                      width: 106.w,
                                                      color: Colors.amber,
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Image.file(
                                                            addReturnsController.selectedImages.value[index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Positioned(
                                                            top: 3.h,
                                                            left: 3.w,
                                                            child: InkWell(
                                                              onTap: () {
                                                                addReturnsController.selectedImages.removeAt(
                                                                    addReturnsController.selectedImages.indexWhere((element) => element.path == addReturnsController.selectedImages.value[index].path));
                                                                addReturnsController.selectedImages.forEach((element) {
                                                                  print(element.path);
                                                                });

                                                                print('asd');
                                                              },
                                                              child: Icon(
                                                                Icons.close_rounded,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20.0.h),
                                        child: MainButton(
                                            text: 'إرسال',
                                            width: 178.w,
                                            height: 50.h,
                                            onPressed: () async {
                                              FocusScope.of(context).requestFocus(FocusNode());

                                              if (addReturnsController.validate()) {
                                                var uploadImagesStatus = await addReturnsController.uploadReturnsImagesPaths();

                                                if (uploadImagesStatus == 'ok') {
                                                  print('okokokokkokokkkokookk');
                                                  var addReturnsStatus = await addReturnsController.addReturns();

//

//
                                                  if (addReturnsStatus == '200')
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
                                                  // }
                                                }
                                              }
                                            }),
                                      ),
                                      //     Text(addReturnsController.response1.toString())
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
      ),
    );
  }
}
