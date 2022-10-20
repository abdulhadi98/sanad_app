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
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../helper/enums.dart';

class EnterBoxNumberController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  Rx<TextEditingController> clientNumberController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;
  Rx<TextEditingController> categoriesNumberController = TextEditingController().obs;
  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> boxesNumberController = TextEditingController().obs;

  getOrderById() async {
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(
        Uri.parse(UrlsContainer.getOrderById + '?order_id=${OrdersRootScreen.orderId}'),
        headers: {'Authorization': 'Bearer $token'},
      );
      Map body = jsonDecode(response.body);
      print(body);
      var data = body['data'];
      orderModel = OrderModel.fromJson(data);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message, onData: () {
        setOrderDetails();
      });
      setStatus(Status.DATA);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(
        title: 'خطأ',
        message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
        toastColor: AppColors.red,
      );
      return 'error';
    }
  }

  setOrderDetails() {
    clientNumberController.value.text = orderModel!.clientNumber.toString(); //TODO why client num static??
    invoiceNumberController.value.text = orderModel!.invoiceNumber!;
    categoriesNumberController.value.text = orderModel!.categoriesNumber.toString();
    addressController.value.text = orderModel!.regionName! + ', ' + orderModel!.cityName!;
    detailsController.value.text = orderModel!.details ?? 'لا توجد تفاصيل';
  }

  enterBoxesNumber() async {
    dynamic response;
    setStatus(Status.LOADING);
    try {
      print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.enterBoxesNumber,
        ),
        body: {'order_id': Get.arguments['order_id'], 'box_number': boxesNumberController.value.text.toString(), 'incpection_officer_id': '14'},
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

  bool validateInputs() {
    if (boxesNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال عدد الصناديق', toastColor: AppColors.red);
      return false;
    }
    dynamic boxNumber = int.parse(boxesNumberController.value.text);
    if (boxNumber < 1) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يجب أن يكون عدد الصناديق أكبر من الصفر', toastColor: AppColors.red);
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    getOrderById();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
