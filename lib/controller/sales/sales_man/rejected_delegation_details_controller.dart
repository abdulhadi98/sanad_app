import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/delegation_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';

class RejectDelegationDetailsController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;
  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> rejectDetailsController = TextEditingController().obs;

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  String? accessToken;
  List<ClientModel> clientsList = [];

  DelegationModel? delegationModel;

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
      salesmanId = data['creator_id'];

      delegationModel = DelegationModel.fromJson(data);
      setDelegationInitailInfo();

      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      setStatus(Status.DATA);
      return code; //return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  setDelegationInitailInfo() {
    // print(delegationModel!.clientNumber.toString());
    // print(delegationModel!.details.toString());
    // invoiceNumberController.value.text=delegationModel!,
    clientNumberController.value.text = delegationModel!.clientNumber.toString();
    detailsController.value.text = delegationModel!.details!;
    rejectDetailsController.value.text = delegationModel!.acceptedDetails!;
  }

  OrderModel? orderModel;
  var salesmanId;

  @override
  void onInit() {
    getDelegationById();
    //addressController.value.text = 'address';
    super.onInit();
    //  setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
