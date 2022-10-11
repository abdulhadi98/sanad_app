import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/controller/general/note_details_controller.dart';
import 'package:wits_app/controller/general/notes_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/delegation_details_sales_employee_controller.dart';
import 'package:wits_app/controller/sales/sales_employee/get_delegation_details_and_add_order_from_delegation_controllrer.dart';
import 'package:wits_app/controller/sales/sales_man/rejected_delegation_details_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/add_order_from_delegation_screen_controller.dart';
import 'package:wits_app/controller/sales/sales_manger/delegation_details_screen_controller.dart';
import 'package:wits_app/helper/enums.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/view/common_wigets/drawer.dart';
import 'package:wits_app/view/common_wigets/main_button.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import '../../../../controller/global_controller.dart';
import '../common_wigets/bottom_nav_bar.dart';
import '../common_wigets/header_widget.dart';

class ResetPasswordNotificationScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //TextEditingController myController = TextEditingController();

  final GlobalController globalController = Get.find<GlobalController>();
  final TextEditingController bodyController = TextEditingController(text: Get.arguments['reset_password']);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    //  globalController.scaffoldKey = scaffoldKey;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      endDrawer: AppDrawer(scaffoldKey: scaffoldKey),
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
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
                          title: "",
                          scaffoldKey: scaffoldKey,
                        ),
               
                        Column(
                          children: [
                            TitleWidget(tilte: '“ طلب إعادة تعيين كلمة السر ”'),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextFieldTall(
                              enabled: false,
                              height: 158.h,
                              textEditingController: bodyController,
                              hint: 'الملاحظة',
                              onChanged: (val) {},
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: MainButton(
                                text: 'عودة',
                                width: 178.w,
                                height: 50.h,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        )
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
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SalesMangerRootScreen()), (Route<dynamic> route) => false);
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
