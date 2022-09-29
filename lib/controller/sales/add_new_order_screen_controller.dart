import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:wits_app/model/sales_empolyee_model.dart';
import 'package:wits_app/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class AddNewOrderScreenController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;
  Rx<TextEditingController> categoriesNumberController = TextEditingController().obs;
  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  String? accessToken;
  List<ClientModel> clientsList = [];

  getUsersInfo() async {
    clientsList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getClientsInfo), headers: {'Authorization': 'Bearer $token'});
      Map body = jsonDecode(response.body);
      print(body);
      List<dynamic> data = body['data'];
      clientsList = List<ClientModel>.from(data.map((x) => ClientModel.fromJson(x)).toList());

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

  addNewOrder() async {
    dynamic response;
    spinner.value = true;

     try {
    print(orderModel!.toJson());
    String? token = await sharedPreferences!.getString("token");
    response = await http.post(
        Uri.parse(
          UrlsContainer.addNewOrder,
        ),
        body: orderModel!.toJson(),
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
       Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
       return 'error';
     }
  }

  addNewOrderSuperManager() async {
    dynamic response;
    spinner.value = true;

    try {
      print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addNewOrderSuperManager,
          ),
          body: orderModel!.toJson(),
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
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  bool validateInputs() {
    if (clientNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى أختيار رقم العميل', toastColor: AppColors.mainColor1);
      return false;
    }
    if (invoiceNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال رقم الفاتورة', toastColor: AppColors.mainColor1);
      return false;
    }
    if (categoriesNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال عدد الأصناف', toastColor: AppColors.mainColor1);
      return false;
    }
    return true;
  }

  OrderModel? orderModel;

  setOrderModel() async {
    print(await sharedPreferences!.getInt('user_id').toString());
    addressController.value.text = clientsList.firstWhere((element) => element.clientNumber.toString() == clientNumberController.value.text).regionName.toString() +
        ', ' +
        clientsList.firstWhere((element) => element.clientNumber.toString() == clientNumberController.value.text).cityName.toString();
    print(clientsList.first.clientNumber);
    print(clientNumberController.value.text);
    orderModel = OrderModel(
        clientNumber: clientNumberController.value.text,
        creatorId: await sharedPreferences!.getInt('user_id'),
        commercialRecord: clientNumberController.value.text,
        address: addressController.value.text,
        invoiceNumber: invoiceNumberController.value.text,
        categoriesNumber: categoriesNumberController.value.text,
        details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
        warehouseId: sharedPreferences!.getInt('warehouse_id') == null ? '0' : sharedPreferences!.getInt('warehouse_id').toString());
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //  setStatus(Status.LOADING);
    getUsersInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
