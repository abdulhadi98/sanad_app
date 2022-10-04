import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/login_screen_controller.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import '../common_wigets/main_button.dart';
import '../common_wigets/textfield_custom.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var put = Get.lazyPut<LoginScreenController>(
    () => LoginScreenController(),
  ); // or optionally with tag
  LoginScreenController loginScreenController = Get.find<LoginScreenController>();
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
                  () => loginScreenController.spinner.value
                      ? SizedBox(
                          height: height / 1.5,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            TextFieldCustom(
                              textDirection: TextDirection.ltr,
                              textEditingController: loginScreenController.emailController,
                              hint: "اسم المستخدم",
                              onChanged: (val) {
                                print(val);
                              },
                            ),
                            SizedBox(
                              height: 29.h,
                            ),
                            TextFieldCustom(
                              textDirection: TextDirection.ltr,
                              textEditingController: loginScreenController.passwordController.value,
                              hint: "كلمة المرور",
                              isPassword: true,
                              onChanged: (val) {
                                print(val);
                              },
                            ),
                            SizedBox(
                              height: 71.h,
                            ),
                            MainButton(
                              text: 'تسجيل الدخول',
                              height: 50.h,
                              width: 238.w,
                              onPressed: () async {
                                dynamic status = await loginScreenController.signIn();
                                print(status);
                              },
                            ),
                            SizedBox(
                              height: 21.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'نسيت كلمة المرور',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    color: AppColors.brown,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 14,
                                    color: AppColors.brown,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 135.h,
                            ),
                            MainButton(
                              text: 'عودة',
                              height: 50.h,
                              width: 136.w,
                              //    height: 50.h,
                              onPressed: () {
                                print('عودة');
                              },
                            ),
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
