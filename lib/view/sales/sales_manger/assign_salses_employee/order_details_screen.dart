import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../../../common_wigets/bottom_nav_bar.dart';
import '../../../common_wigets/dilog_custom.dart';
import '../../../common_wigets/header_widget.dart';
import '../../../common_wigets/title_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.mainColor1,
    //   statusBarBrightness: Brightness.dark,
    // ));
    double width = MediaQuery.of(context).size.width;
    //

    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
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
                          title: "مدير قسم المبيعات",
                          scaffoldKey: scaffoldKey,
                        ),
                        TitleWidget(
                          tilte: 'تفاصيل الطلب',
                        ),
                        TextFieldCustom(
                            hint: 'أدخل اسم العميل', onChanged: (val) {}),
                        SizedBox(
                          height: 17.h,
                        ),
                        TextFieldTall(
                          focusNode: focusNode,
                          hint: 'rdg الطلبية',
                          onChanged: (val) {},
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: MainButton(
                            text: 'إرسال',
                            width: 178.w,
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
                                      // color: AppColors.white.withOpacity(0.9),
                                      height: height,
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.w,
                                              vertical: 15.h,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                          TitleWidget(tilte: 'هل أنت متأكد؟'),
                                          SizedBox(
                                            height: 185.h,
                                          ),
                                          MainButton(
                                            text: 'لا',
                                            width: 232.w,
                                            color: AppColors.red,
                                            height: 50.h,
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          SizedBox(
                                            height: 35.h,
                                          ),
                                          MainButton(
                                            text: 'نعم',
                                            width: 232.w,
                                            //    color: AppColors.red,
                                            height: 50.h,
                                            onPressed: () {
                                              Get.back();

                                              showDialogCustom(
                                                height: height,
                                                width: width,
                                                context: context,
                                                padding: EdgeInsets.zero,
                                                dialogContent: StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SalesMangerRootScreen(),
                                                                ),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                      },
                                                      child: Container(
                                                        //       color: AppColors.white,
                                                        height: height,
                                                        width: width,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    15.w,
                                                                vertical: 15.h,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/icons/Icon Close Light-1.svg',
                                                                      width:
                                                                          16.w,
                                                                      height:
                                                                          16.w,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height / 3,
                                                            ),
                                                            TitleWidget(
                                                              tilte: 'شكراً لك',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SalesMangerRootScreen(),
                        ),
                      );
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
