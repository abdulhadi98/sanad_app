import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:wits_app/controller/incpection_officer/enter_box_number_controller.dart';
import 'package:wits_app/controller/returns_manger/receive_returns_controller.dart';
import 'package:wits_app/controller/returns_manger/return_details_controller.dart';
import 'package:wits_app/helper/app_colors.dart';

import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import 'package:wits_app/view/warehouse_manger/assign_preparator_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class ReturnsDetailsScreen extends StatelessWidget {
  final returnDetailsController = Get.put<ReturnDetailsController>(ReturnDetailsController());
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
                      title: "",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (returnDetailsController.status!.value) {
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
                                    TitleWidget(tilte: 'تفاصيل المرتجعات'),
                                    Container(
                                      //  color: Colors.red,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 45.0.w),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 12.0.h),
                                              child: StepsIndicator(
                                                selectedStep: returnDetailsController.returnDetailsModel!.returnsIsDelivered == 1 ? 1 : 0,
                                                nbSteps: 2,
                                                doneLineColor: Colors.green, //line
                                                doneStepColor: Colors.green,
                                                undoneLineColor: Color(0xFFE5E5E5), //line
                                                selectedStepColorIn: Colors.orange,
                                                selectedStepColorOut: Color(0xFFE5E5E5),
                                                unselectedStepColorIn: Colors.transparent,
                                                unselectedStepColorOut: Color(0xFFE5E5E5),
                                                isHorizontal: false,
                                                lineLength: 33.h,
                                                lineLengthCustomStep: [
                                                  StepsIndicatorCustomLine(
                                                    nbStep: 1,
                                                    length: 40,
                                                  )
                                                ],
                                                enableLineAnimation: true,
                                                enableStepAnimation: true,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              children: [
                                                ReturnsProcessWidget(
                                                  processName: "تم الاستلام",
                                                  onDetailsPressed: () {},
                                                  processCreateDate: returnDetailsController.returnDetailsModel!.createdAt!,
                                                ),
                                                ReturnsProcessWidget(
                                                  processName: "تم الاستلام",
                                                  onDetailsPressed: () {},
                                                  processCreateDate: returnDetailsController.returnDetailsModel!.createdAt!,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 15.0.h, left: 12.w, top: 8.h),
                                                  child: Text(
                                                    'تم الاستلام',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 14.sp, fontWeight: FontWeight.w200),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 15.0.h, left: 12.w, top: 8.h),
                                                  child: Text(
                                                    'تم التسليم',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 14.sp, fontWeight: FontWeight.w200),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'رقم العميل',
                                      textEditingController: returnDetailsController.clientNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: 'رقم الفاتورة',
                                      textEditingController: returnDetailsController.invoiceNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false,
                                      height: 158.h,
                                      textEditingController: returnDetailsController.detailsController.value,
                                      hint: 'تفاصيل المرتجعات',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    if (returnDetailsController.returnsImages.length != 0)
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 295.w,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                ':صور المرتجعات',
                                                style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 305.w,
                                            height: returnDetailsController.returnsImages.length > 2 ? 300.h : 170.h,
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
                                                itemCount: returnDetailsController.returnsImages.length,
                                                itemBuilder: (BuildContext ctx, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      showDialogCustom(
                                                          context: context,
                                                          padding: EdgeInsets.zero,
                                                          dialogContent: DialogContentSingleImage(path: returnDetailsController.returnsImages[index]),
                                                          height: height,
                                                          width: width);
                                                    },
                                                    child: Container(
                                                      height: 91.h,
                                                      width: 106.w,
                                                      //   color: Colors.amber,
                                                      child: Image.network(
                                                        UrlsContainer.imagesUrl + '/' + returnDetailsController.returnsImages[index],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    if (returnDetailsController.invoiceImage.isNotEmpty)
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 295.w,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                ':صورة فاتورة المرتجعات',
                                                style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialogCustom(
                                                  context: context,
                                                  padding: EdgeInsets.zero,
                                                  dialogContent: DialogContentSingleImage(path: returnDetailsController.invoiceImage.first),
                                                  height: height,
                                                  width: width);
                                            },
                                            child: Container(
                                              width: 295.w,
                                              height: 220.h,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(25.r),
                                                  border: Border.all(
                                                    color: AppColors.mainColor1,
                                                  )),
                                              padding: EdgeInsets.all(19.r),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10.r),
                                                child: Image.network(
                                                  '${UrlsContainer.imagesUrl}\/${returnDetailsController.invoiceImage.first}',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: MainButton(
                                        text: 'عودة',
                                        width: 232.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          Get.back();
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

class ReturnsProcessWidget extends StatelessWidget {
  ReturnsProcessWidget({this.onDetailsPressed, this.processCreateDate, required this.processName});
  final String processName;
  final DateTime? processCreateDate;
  final Function? onDetailsPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: 9.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //  alignment: Alignment.centerRight,
                //   width: 100.w,
                child: Text(
                  processCreateDate == null ? '' : Utils.formatProcessTime(processCreateDate!),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF798186), fontSize: 10.sp, fontWeight: FontWeight.w200),
                ),
              ),
              FutureBuilder<String>(
                future: Utils.formatProcessDate(processCreateDate ?? 'null'), // async work
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('');
                    default:
                      if (snapshot.hasError)
                        return Text('');
                      else
                        return Text(
                          snapshot.data!,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Color(0xFF798186), fontSize: 12.sp, fontWeight: FontWeight.w200),
                        );
                  }
                },
              )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
