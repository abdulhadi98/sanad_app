import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

class PrintOrderController extends GetxController {
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

 
  getOrderById() async {
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getOrderById + '?order_id=${OrdersRootScreen.orderId}'), headers: {'Authorization': 'Bearer $token'});
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
        title: '??????',
        message: '?????? ?????? ?????? ??????????, ???????? ???????????????? ????????????',
        toastColor: AppColors.red,
      );
      return 'error';
    }
  }

  setOrderDetails() {
    clientNumberController.value.text = '21312'; //TODO why client num static??
    invoiceNumberController.value.text = orderModel!.invoiceNumber!;
    categoriesNumberController.value.text = orderModel!.categoriesNumber.toString();
    addressController.value.text = orderModel!.regionName! + ', ' + orderModel!.cityName!;
    detailsController.value.text = orderModel!.details!;
  }

  printOder() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.printOrder,
          ),
          body: {'order_id': OrdersRootScreen.orderId.toString()},
          headers: {'Authorization': 'Bearer $token'});
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
      Utils.showGetXToast(title: '??????', message: '?????? ?????? ?????? ??????????, ???????? ???????????????? ????????????', toastColor: AppColors.red);
      return 'error';
    }
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
    getOrderById();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
