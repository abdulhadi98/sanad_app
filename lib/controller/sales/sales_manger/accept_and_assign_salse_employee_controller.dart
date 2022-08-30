import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';
import '../../../model/delegation_model.dart';

class AcceptAndAssignSalesEmployeeController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  String? accessToken;

  addDelegationManger() async {
    dynamic response;
    setStatus(Status.LOADING);

    // try {
    // print(delegationModel!.toJsonManger());
    String? token = await sharedPreferences!.getString("token");
    response = await http.post(
        Uri.parse(
          UrlsContainer.addDelegationManger,
        ),
        body: delegationModel!.toJsonManger(),
        headers: {'Authorization': 'Bearer $token'});

    dynamic body = jsonDecode(response.body);
    print(body);
    spinner.value = false;
    String code = body['code'].toString();
    String message = body['message'];
    setStatus(Status.DATA);

    Utils.getResponseCode(code, message, onData: () {});

    return code;
    // } catch (e) {
    //   print(e);
    //   spinner.value = false;
    //   Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
    //   return 'error';
    // }
  }

  //

  DelegationModel? delegationModel;

  setDelegationInfo({clienNumber, details, creatorId, employeeId}) {
    clientNumberController.value.text = clienNumber;
    detailsController.value.text = details;
  }

  setDelegation() async {
    delegationModel = DelegationModel(
      clientNumber: clientNumberController.value.text,
      creatorId: await sharedPreferences!.getInt('user_id').toString(),
      details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
    );
  }

  int? employeeId;
  setDelegationManger(DelegationModel getDelegationModel) {
    print(getDelegationModel.creatorId);
    print(getDelegationModel.employeeId);
    print(getDelegationModel.details);
    print(getDelegationModel.clientNumber);

    delegationModel = getDelegationModel;
    // DelegationModel(
    //     clientNumber: clientNumberController.value.text,
    //     creatorId: sharedPreferences!.getInt('user_id').toString(),
    //     details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
    //     employeeId: employeeId);
  }

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
//bool validateInputs() {
//   if (clientNumberController.value.text.isEmpty) {
//     Utils.showGetXToast(title: 'تنبيه', message: 'يرجى أختيار رقم العميل', toastColor: AppColors.mainColor1);
//     return false;
//   }
//   if (detailsController.value.text.isEmpty) {
//     Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال تفاصيل الطلبية', toastColor: AppColors.mainColor1);
//     return false;
//   }

//   return true;
// }
