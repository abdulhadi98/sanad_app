import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/delegation_model.dart';

import 'package:http/http.dart' as http;
import 'package:wits_app/model/order_details_model.dart';

import 'package:wits_app/model/order_model.dart';
import 'package:wits_app/model/return_details_model.dart';
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/sales/sales_manger/orders/order_from_salesperson_screen.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../helper/enums.dart';
import '../../view/sales/sales_manger/sales_manger_root_screen.dart';

class ReturnDetailsController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;

  List<ClientModel> clientsList = [];
  ReturnDetailsModel? returnDetailsModel;
  var employeeId;
  late final selectedProcessIndex;
  getProcessDate(date) async {
    await Utils.formatProcessDate(date!);
  }

  List<String> returnsImages = [];
  List<String> invoiceImage = [];

  reciveReturns() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      // print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.receiveReturns,
        ),
        body: {'returns_id': Get.arguments['returns_id']},
        headers: {'Authorization': 'Bearer $token'},
      );
      dynamic body = jsonDecode(response.body);
      print(body);
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(code, message);
      setStatus(Status.DATA);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  getReturnById() async {
    setStatus(Status.LOADING);

    String? token = await sharedPreferences!.getString("token");
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getReturnById + '?returns_id=${Get.arguments['returns_id']}'), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      //List<dynamic> data = body['data'];
      var data = body['data'];

      returnDetailsModel = ReturnDetailsModel.fromJson(data);
      setReturnDetials();
      setReturnsImages();
      setInvoiceImages();

      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      setStatus(Status.DATA);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  setReturnsImages() async {
    returnDetailsModel!.images!.forEach((element) {
      returnsImages.add(element.path!);
    });
    print('aaaaa' + returnsImages.toString());
  }

  setInvoiceImages() async {
    returnDetailsModel!.invoiceImage!.forEach((element) {
      invoiceImage.add(element.path!);
    });
    print('sdsdf' + invoiceImage.toString());
  }

  setReturnDetials() {
    clientNumberController.value.text = returnDetailsModel!.clientNumber!.toString();
    detailsController.value.text = returnDetailsModel!.details ?? 'لا توجد تفاصيل';
    invoiceNumberController.value.text = returnDetailsModel!.invoiceNumber.toString();
  }

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  @override
  void onInit() {
    getReturnById();

    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
    // getDelegationById();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
