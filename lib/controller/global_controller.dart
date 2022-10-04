import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper/app_colors.dart';
import '../helper/utils.dart';
import '../main.dart';
import '../model/user_model.dart';
import '../network/urls_container.dart';

class GlobalController extends GetxController {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  RxString userName = ' '.obs;
  getUser() async {
    String? accessToken = sharedPreferences!.getString('token');
    String userId = sharedPreferences!.getInt('user_id').toString();
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getUser + '?user_id=$userId'), headers: {'Authorization': 'Bearer $accessToken'});
      dynamic body = jsonDecode(response.body);
      print(body);
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body)['data']);
      print(userModel.accessToken);
      // spinner.value = false;
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(code, message, onData: () {
        print('200 OK' + userModel.name!);
        userName.value = userModel.name!;
      });
      return code;
    } catch (e) {
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  Future<String?> pushFCMtoken() async {
    String? deviceToken = await messaging.getToken();
    print(";;;;;;;" + deviceToken!);
    return deviceToken;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification = FlutterLocalNotificationsPlugin();
  void initMessaging() {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails = AndroidNotificationDetails('1', 'channelName', channelDescription: 'channelDescription');
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title, notification.body, generalNotificationDetails);
      }
    });
  }

  void openDrawer(scaffoldKey) {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer(scaffoldKey) {
    scaffoldKey.currentState!.openDrawer();
  }

  RxBool logoutSpinner = false.obs;
  removeDeviceToken() async {
    dynamic response;
    logoutSpinner.value = true;

    try {
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.removeDeviceToken,
          ),
          body: {'user_id': ''},
          headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(code, message);
      logoutSpinner.value = false;

      return code;
    } catch (e) {
      print(e);
      logoutSpinner.value = false;

      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  bool? isManager;
  isRoleManager() async {
    var roleId = await sharedPreferences!.getInt('role');
    print('yuiyuiyuiyui ' + roleId.toString());

    if (roleId == 2 || roleId == 3 || roleId == 4 || roleId == 8) {
      isManager = false;
      return isManager;
    }
    isManager = true;
    return isManager;
  }

  @override
  void onInit() {
    // print('qweqweqweqweqweqweqweqweqweqwe' + isRoleManager().toString());
    getUser();
    print(isRoleManager());
    pushFCMtoken();
    initMessaging();
    super.onInit();
  }
}
