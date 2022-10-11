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

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool spinner = false.obs;

  forgotPassword() async {
    if (emailController.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اسم المستخدم أو الإيميل الخاص بك', toastColor: AppColors.orange);
      return;
    }
    spinner.value = true;
    try {
      dynamic response = await http.post(Uri.parse(UrlsContainer.forgotPassword), body: {
        'email': emailController.text,
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
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
