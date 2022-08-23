import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:wits_app/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';
import '../../model/delegation_model.dart';

class RejectDelegationController extends GetxController {
  Rx<TextEditingController> detailsController = TextEditingController().obs;

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  String? accessToken;

  rejectDelegation() async {
    dynamic response;
    spinner.value = true;

    try {
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.rejectDelegation,
          ),
          body: {'delegation_id': '7', 'details': detailsController.value.text},
          headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      spinner.value = false;
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(code, message);
      return code;
    } catch (e) {
      print(e);
      spinner.value = false;
      Utils.showGetXToast(
          title: 'خطأ',
          message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
          toastColor: AppColors.red);
      return 'error';
    }
  }

  bool validateInputs() {
    if (detailsController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى إدخال تفاصيل الرفض',
          toastColor: AppColors.mainColor1);
      return false;
    }

    return true;
  }

  DelegationModel? delegationModel;

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //  setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
