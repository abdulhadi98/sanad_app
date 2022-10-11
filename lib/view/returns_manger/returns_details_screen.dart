import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                                    TitleWidget(tilte: 'تفاصيل الطلبية الجديدة'),
                                    
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
  //  Widget buildGalleryList() {
  //   return Container(
  //     height: (width - 2 * width * .05 - 2 * width * .02) / 3,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: personalAssetPhotos.length,
  //       padding: EdgeInsets.zero,
  //       itemBuilder: (context, index) {
  //         return Row(
  //           children: [
  //             galleryItem(personalAssetPhotos, index,
  //                 (width - 2 * width * .05 - 2 * width * .02) / 3),
  //             if (index != (personalAssetPhotos.length) - 1)
  //               SizedBox(
  //                 width: width * .02,
  //               )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
  // galleryItem(List<PersonalAssetPhotos> photos, index, itemSize) {
  //   List<String> urls = personalAssetPhotos
  //       .map((e) => '${UrlsContainer.baseUrl}/${e.link}')
  //       .toList(); //ggg

  //   return GestureDetector(
  //     onTap: () {
  //       print(photos[index].link);
  //       RoutesHelper.navigateToGalleryScreen(
  //           gallery: urls, index: index, context: context);
  //     },
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
  //             child: ImageWidget(
  //                 url: '${UrlsContainer.baseUrl}/${photos[index].link}',
  //                 width: itemSize,
  //                 height: itemSize,
  //                 fit: BoxFit.cover),
  //           ),
  //         ),
  //         Positioned(
  //           right: 0,
  //           top: 0,
  //           // top: 0,
  //           child: GestureDetector(
  //             onTap: () {
  //               print(photos[index].link! + index.toString());

  //               print(photosUrl);

  //               print(photosUrl.length);
  //               photosUrl.removeWhere((element) {
  //                 if (element == photos[index].link) {
  //                   print('found and delete( $element)');
  //                 }

  //                 return element == photos[index].link!;
  //               });

  //               updateAsset(() {});

  //               print(photosUrl.length);
  //             },
  //             child: Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(4),
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: AppColors.white, width: .5),
  //                 shape: BoxShape.circle,
  //                 color: AppColors.mainColor,
  //               ),
  //               child: Icon(
  //                 Icons.delete_outline_outlined,
  //                 color: AppColors.gray,
  //                 size: width * .04,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
