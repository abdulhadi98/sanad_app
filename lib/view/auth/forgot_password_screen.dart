import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/general/forgot_password_controller.dart';
import 'package:wits_app/controller/login_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import '../common_wigets/main_button.dart';
import '../common_wigets/textfield_custom.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final put = Get.lazyPut<ForgotPasswordController>(
    () => ForgotPasswordController(),
  ); // or optionally with tag
  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //  AppConstant.screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.r),
                      bottomRight: Radius.circular(40.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor1.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 30,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Utils.buildImage(url: 'assets/icons/header_logo.svg', height: 120.w, width: 120.w),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => forgotPasswordController.spinner.value
                      ? SizedBox(
                          height: height / 1.5,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 130.h,
                            ),
                            TextFieldCustom(
                              textDirection: TextDirection.ltr,
                              textEditingController: forgotPasswordController.emailController,
                              hint: "اسم المستخدم",
                              onChanged: (val) {
                                print(val);
                              },
                            ),

                            SizedBox(
                              height: 30.h,
                            ),
                            MainButton(
                              text: 'إرسال إلى مسؤول التحكم',
                              height: 50.h,
                              width: 238.w,
                              onPressed: () async {
                                showDialogCustom(
                                  height: height,
                                  width: width,
                                  context: context,
                                  padding: EdgeInsets.zero,
                                  dialogContent: DialogContentAreYouSure(
                                    onYes: () async {
                                      dynamic status = await forgotPasswordController.forgotPassword();
                                      if (status == '200')
                                        showDialogCustom(
                                          height: height,
                                          width: width,
                                          context: context,
                                          padding: EdgeInsets.zero,
                                          dialogContent: DialogContentThanks(
                                            onTap: () {
                                              Get.offAllNamed('/');
                                            },
                                          ),
                                        );
                                    },
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 21.h,
                            ),

                            // SizedBox(
                            //   height: 135.h,
                            // ),
                            // MainButton(
                            //   text: 'عودة',
                            //   height: 50.h,
                            //   width: 136.w,
                            //   //    height: 50.h,
                            //   onPressed: () {
                            //     print('عودة');
                            //   },
                            // ),
                          ],
                        ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 26.h,
                  color: AppColors.brown,
                  child: Text(
                    '®WITS 2022 all right reserved',
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 9.sp, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
