import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/driver/deliver_to_driver_controller.dart';
import 'package:wits_app/controller/order_details_controller.dart';
import 'package:wits_app/helper/app_colors.dart';

import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/worker_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class DeliverToDriverScreen extends StatelessWidget {
  final put = Get.lazyPut<DeliverToDriverController>(
    () => DeliverToDriverController(),
    fenix: true,
  );
  final DeliverToDriverController deliverToDriverController = Get.find<DeliverToDriverController>();
  final OrderDetailsController orderDetailsController = Get.find<OrderDetailsController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalController globalController = Get.find<GlobalController>();

//  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                      title: "السائق",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (deliverToDriverController.status!.value) {
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
                                    TitleWidget(tilte: "التسليم إلى سائق آخر"),
                                    MainButton(
                                      text: 'اختر السائق',
                                      width: 295.w,
                                      height: 50.h,
                                      onPressed: () {
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
                                                      'اختر  السائق',
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
                                                          itemCount: deliverToDriverController.driversList.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return WorkerWidget(
                                                                imageUrl: deliverToDriverController.driversList[index].imagePorofile ?? 'assets/images/worker1.png',
                                                                workerName: deliverToDriverController.driversList[index].name!,
                                                                workerDepartment: '',
                                                                onPressed: () {
                                                                  deliverToDriverController.driverId = deliverToDriverController.driversList[index].id;
                                                                  //  SalesMangerRootScreen.salesmanId = driversController.driversList[index].id;
                                                                  print(deliverToDriverController.driverId);
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
                                      height: 15.h,
                                    ),
                                    MainButtonWithIcon(
                                      loadingLocation: deliverToDriverController.locationSpinner.value,
                                      text: 'تحديد الموقع تلقائياً',
                                      width: 295.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        var postion = await deliverToDriverController.determinePosition();
                                        print(postion.latitude.toString() + ', ' + postion.longitude.toString());
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    MainButton(
                                      text: deliverToDriverController.selectedImages.length == 0 ? 'تصوير سيارة السائق' : 'إضافة صور أخرى',
                                      width: 295.w,
                                      height: 50.h,
                                      onPressed: () async {
                                        deliverToDriverController.pickImage();
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    deliverToDriverController.selectedImages.length != 0
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
                                                itemCount: deliverToDriverController.selectedImages.length,
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
                                                          deliverToDriverController.selectedImages.value[index],
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Positioned(
                                                          top: 3.h,
                                                          left: 3.w,
                                                          child: InkWell(
                                                            onTap: () {
                                                              deliverToDriverController.selectedImages.removeAt(deliverToDriverController.selectedImages
                                                                  .indexWhere((element) => element.path == deliverToDriverController.selectedImages.value[index].path));
                                                              deliverToDriverController.selectedImages.forEach((element) {
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
                                      height: 15.h,
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.0.h),
                                      child: MainButton(
                                          text: 'إرسال',
                                          width: 178.w,
                                          height: 50.h,
                                          onPressed: () async {
                                            if (deliverToDriverController.validate()) {
                                              var uploadImagesStatus = await deliverToDriverController.uploadDriverTruckImages();
                                              if (uploadImagesStatus == 'ok') {
                                                print('okokokokkokokkkokookk');

                                                var changeDriverStatus = await deliverToDriverController.changeDriver();

                                                if (changeDriverStatus == '200')
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
