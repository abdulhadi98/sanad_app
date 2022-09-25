import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/app_constant.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';

import '../common_wigets/main_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    pushFCMtoken();
    initMessaging();
  }

  void pushFCMtoken() async {
    String? token = await messaging.getToken();
    print(token);
  }

  void initMessaging() {
    var androiInit =
        AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails = AndroidNotificationDetails('1', 'channelName',
        channelDescription: 'channelDescription');
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppConstant.screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: Theme(
              data: Theme.of(context).copyWith(
                // Set the transparency here
                canvasColor: Colors.white.withOpacity(
                    .60), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8.0,
                      sigmaY: 8.0,
                    ),
                    child: Drawer(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: const Icon(Icons.list),
                                trailing: const Text(
                                  "GFG",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                title: Text("List item $index"));
                          }),
                      // All other codes goes here.
                    ),
                  ),
                ),
              ),
            ),
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
                        height: 10.h + MediaQuery.of(context).padding.top,
                      ),
                      Text(
                        'سند',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 72.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            height: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: Text(
                          'تطبيق تتبع طلبات المستودعات من WITS',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            //letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Get.toNamed('/sales-manger-root-screen');
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'موظف المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Get.toNamed('/sales-employee-root-screen');
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مندوب المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Get.toNamed('/salesman-root-screen-new');
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: '<',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Get.toNamed('/');
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'Notification',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              FirebaseMessaging.instance
                                  .getToken()
                                  .then((value) => print(value));
                              FirebaseMessaging.onMessage
                                  .listen((RemoteMessage message) {
                                print(
                                    'Got a message whilst in the foreground!');
                                print('Message data: ${message.data}');

                                if (message.notification != null) {
                                  print(
                                      'Message also contained a notification: ${message.notification!.title}');
                                }
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => SalesMangerRootScreen(),
                              //   ),
                              // );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainButton(
                            text: 'مدير المبيعات',
                            height: 50.h,
                            width: 295.w,
                            //    height: 50.h,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesMangerRootScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 26.h,
                  color: AppColors.brown,
                  child: Text(
                    '®WITS 2022 all right reserved',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 9.sp,
                        letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
