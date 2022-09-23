import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/diver_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class ReviewByOrderController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  Rx<TextEditingController> reviewController = TextEditingController().obs;

  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;

  List<OrderModel> ordersList = [];
  getOrderId(invoice) {
    orderId = ordersList.firstWhere((element) => element.invoiceNumber == invoice).id;
  }

  int? orderId;

  addReview() async {
    dynamic response;
    setStatus(Status.LOADING);
    try {
      // print(UrlsContainer.addOrderIdToDelegation + ' ' + returnsOrderId.toString() + ' ' + Get.arguments['delegation_id'].toString());
      // print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" + returnsOrderId.toString());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addReviewById,
          ),
          body: {'order_id': orderId.toString(), 'employee_id': employeeId.toString(), 'note': reviewController.value.text},
          headers: {'Authorization': 'Bearer $token'});
      //   print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" + returnsOrderId.toString());

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

  getOrders() async {
    ordersList.clear();
    String? token = await sharedPreferences!.getString("token");
    print(token);
    print(Uri.parse(UrlsContainer.baseApiUrl + '/get-orders'));
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.baseApiUrl + '/get-orders'), headers: {'Authorization': 'Bearer $token'});
      Map body = jsonDecode(response.body);
      print(body);
      List<dynamic> data = body['data'];
      ordersList = List<OrderModel>.from(data.map((x) => OrderModel.fromJson(x)).toList());
      setStatus(Status.DATA);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  int? employeeId;
  List<DriverModel> employeeList = [];
  RxBool employeesSpinner = false.obs;

  getEmployeesByOrder() async {
    print(employeesSpinner.value);
    print(UrlsContainer.getEmployeesByOrder + '?order_id=$orderId');
    employeeList.clear();
    String? token = await sharedPreferences!.getString("token");
    employeesSpinner.value = true;
    print(employeesSpinner.value);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getEmployeesByOrder + '?order_id=$orderId'), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(response.body);
      List<dynamic> data = body['data']; //body['data']
      employeeList = List<DriverModel>.from(data.map((x) => DriverModel.fromJson(x)).toList());

      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      employeesSpinner = false.obs;
      print(employeesSpinner.value);

      return code;
    } catch (e) {
      print(e);
      employeesSpinner = false.obs;
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  bool validate() {
    if (invoiceNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار طلبية', toastColor: AppColors.red);
      return false;
    }
    if (employeeId == null) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار السائق الآخر', toastColor: AppColors.red);
      return false;
    }
    if (reviewController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى كتابة ملاحظة', toastColor: AppColors.red);
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    getOrders();
    // getDrivers();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
