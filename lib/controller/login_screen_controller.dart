import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxBool spinner = false.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification = FlutterLocalNotificationsPlugin();

  Future<String?> pushFCMtoken() async {
    String? deviceToken = await messaging.getToken();
    print(deviceToken);
    return deviceToken;
  }

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

  signIn() async {
    spinner.value = true;
    try {
      //String? deviceToken = await pushFCMtoken();
      dynamic response = await http.post(Uri.parse(UrlsContainer.emailLogin), body: {
        'email': emailController.value.text,
        'password': passwordController.value.text,
        //    'device_token': deviceToken
      });
      dynamic body = jsonDecode(response.body);
      print(body);
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body)['data']);
      //  print(userModel.accessToken);

      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(
        code,
        message,
        onData: () async {
          sharedPreferences!.setInt('role', userModel.roleId ?? 999);
          sharedPreferences!.setString('user_name', userModel.name ?? '-');
          sharedPreferences!.setString('token', userModel.accessToken ?? 'null');
          sharedPreferences!.setInt('user_id', userModel.id ?? 999);
          var addToken = await addDeviceToken(userModel.accessToken);

          Get.offAllNamed('/root_screen');
        },
      );
      spinner.value = false;
      return code;
    } catch (e) {
      spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  addDeviceToken(accessToken) async {
    spinner.value = true;

    try {
      String? deviceToken = await pushFCMtoken();
      dynamic response = await http.post(Uri.parse(UrlsContainer.addDeviceToken), body: {
        'device_token': deviceToken,
      }, headers: {
        'Authorization': 'Bearer $accessToken'
      });
      dynamic body = jsonDecode(response.body);
      print(body);
      // UserModel userModel =
      //     UserModel.fromJson(jsonDecode(response.body)['data']);
      // //  print(userModel.accessToken);
      // spinner.value = false;
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(
        code,
        message,
      );
      spinner.value = false;
      return code;
    } catch (e) {
      spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  @override
  void onInit() {
    pushFCMtoken();
    initMessaging();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
