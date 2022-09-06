import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/delegation_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';

class DelegationDetailsSalesEmployeeScreenController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;
  Rx<TextEditingController> categoriesNumberController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  // setDelegationInfo({clienNumber, details}) {
  //   clientNumberController.value.text = clienNumber;
  //   detailsController.value.text = details;
  // }
  List<ClientModel> clientsList = [];

  var employeeId;
  DelegationModel? delegationModel;

  setDelegation() async {
    delegationModel = DelegationModel(
      clientNumber: clientNumberController.value.text,
      creatorId: await sharedPreferences!.getInt('user_id').toString(),
      details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
    );
  }

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  RxString employeeName = ' '.obs;
  List<DelegationModel> delegationsList = [];
  int? delegationId;
  getDelegationById() async {
    String? token = await sharedPreferences!.getString("token");
    // int? id = SalesmanOrderScreen.delegationId;
    int? id = Get.arguments['delegation_id'];

    print('delegationId= #$id');
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getDelegationById + '?delegation_id=$id'), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      //List<dynamic> data = body['data'];
      var data = body['data'];

      delegationModel = DelegationModel.fromJson(data);
      employeeName.value = delegationModel!.delegationEmployeeName!;
      print(DelegationModel.fromJson(data));
      setDelegationInfo();
      setStatus(Status.DATA);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      return code; //return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  setDelegationInfo() {
    // print(delegationModel!.clientNumber.toString());
    // print(delegationModel!.details.toString());
    clientNumberController.value.text = delegationModel!.clientNumber.toString();
    detailsController.value.text = delegationModel!.details!;
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
    getDelegationById();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
//  getOrders() async {
//     String? token = await sharedPreferences!.getString("token");
//     dynamic response;
//     spinner.value = true;
//     try {
//       response = await http.post(Uri.parse(UrlsContainer.getORders),
//           headers: {'Authorization': 'Bearer $token'});
//       dynamic body = jsonDecode(response.body);
//       print(body);
//       spinner.value = false;
//       String code = body['code'].toString();
//       String message = body['message'];
//       Utils.getResponseCode(code, message);
//       return code;
//     } catch (e) {
//       print(e);
//       spinner.value = false;
//       Utils.showGetXToast(
//           title: 'خطأ',
//           message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
//           toastColor: AppColors.red);
//       return 'error';
//     }
//   }
