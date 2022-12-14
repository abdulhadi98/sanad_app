import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/incpection_officer/enter_box_number_controller.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/dilog_custom.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/showdialog_are_you_sure.dart';
import 'package:wits_app/view/common_wigets/showdialog_thanks.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class EnterBoxesNumberScreen extends StatelessWidget {
  var put = Get.lazyPut<EnterBoxNumberController>(
    () => EnterBoxNumberController(),fenix: true
  );
  final EnterBoxNumberController enterBoxNumberController = Get.find<EnterBoxNumberController>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
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
                      employeeName: "?????? ????????????",
                      title: "?????????? ??????????",
                      scaffoldKey: scaffoldKey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        child: SingleChildScrollView(
                          child: Obx(() {
                            switch (enterBoxNumberController.status!.value) {
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
                                    TitleWidget(tilte: '???????????? ?????????????? ??????????????'),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: '?????? ????????????',
                                      textEditingController: enterBoxNumberController.clientNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      textEditingController: enterBoxNumberController.invoiceNumberController.value,
                                      hint: '?????? ????????????????',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: false,
                                      hint: '?????? ??????????????',
                                      textEditingController: enterBoxNumberController.categoriesNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false, height: 158.h,

                                      //focusNode: focusNode,
                                      hint: '?????????? ????????????',
                                      textEditingController: enterBoxNumberController.addressController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFieldTall(
                                      enabled: false,
                                      height: 158.h,
                                      textEditingController: enterBoxNumberController.detailsController.value,
                                      hint: '???????????? ????????????',
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    TextFieldCustom(
                                      enabled: true,
                                      hint: '???????? ?????? ????????????????',
                                      keyboardType: TextInputType.number,
                                      textEditingController: enterBoxNumberController.boxesNumberController.value,
                                      onChanged: (val) {},
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 30.h),
                                      child: MainButton(
                                        text: '??????????',
                                        width: 178.w,
                                        height: 50.h,
                                        onPressed: () async {
                                          FocusScope.of(context).requestFocus(FocusNode());

                                          if (enterBoxNumberController.validateInputs()) {
                                            showDialogCustom(
                                              height: height,
                                              width: width,
                                              context: context,
                                              padding: EdgeInsets.zero,
                                              dialogContent: DialogContentAreYouSure(
                                                onYes: () async {
                                                  dynamic status = await enterBoxNumberController.enterBoxesNumber();
                                                  if (status == '200')
                                                    showDialogCustom(
                                                        height: height,
                                                        width: width,
                                                        context: context,
                                                        padding: EdgeInsets.zero,
                                                        dialogContent: DialogContentThanks(onTap: () {
                                                          Get.offAllNamed('/incpection-officer-root-screen');
                                                        }));
                                                },
                                              ),
                                            );
                                            // dynamic status = await enterBoxNumberController.enterBoxesNumber();
                                            // // if (status == '777')
                                            // //   Utils.showGetXToast(
                                            // //       message: status);
                                            // if (status == '200')
                                            //   showDialogCustom(
                                            //     height: height,
                                            //     width: width,
                                            //     context: context,
                                            //     padding: EdgeInsets.zero,
                                            //     dialogContent: DialogContentThanks(
                                            //       onTap: () {
                                            //    Get.offAllNamed('/incpection-officer-root-screen');

                                            // },

                                            //     ),
                                            //   );
                                          }
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
