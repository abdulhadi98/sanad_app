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
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/sales/sales_manger/orders/order_from_salesperson_screen.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../helper/enums.dart';
import '../../view/sales/sales_manger/sales_manger_root_screen.dart';

class OrderDetailsController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController = TextEditingController().obs;
  Rx<TextEditingController> categoriesNumberController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> boxNumberController = TextEditingController().obs;

  List<ClientModel> clientsList = [];
  OrderDetailsModel? orderDetailsModel;
  var employeeId;
  late final selectedProcessIndex;
  getProcessDate(date) async {
    await Utils.formatProcessDate(date!);
  }

  List<Text> statusesNames = [];
  List<String> processesNamesList = [
    'استلام طلب جديد',
    'قيد التحضير',
    'تم التحضير',
    'قيد التسليم',
    'غير مختومة',
    'تم التسليم',
  ];
  getOrderById() async {
    setStatus(Status.LOADING);
    print('order_id=${Get.arguments['order_id']}');
    String? token = await sharedPreferences!.getString("token");
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getOrderById + '?order_id=${Get.arguments['order_id']}'), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      //List<dynamic> data = body['data'];
      var data = body['data'];
      orderDetailsModel = OrderDetailsModel.fromJson(data);

      setOrderDetails();
      print(OrderDetailsModel.fromJson(data));

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

  OrderModel? orderModel;

  // bool validateInputs() {
  //   if (boxNumberController.value.text.isEmpty) {
  //     Utils.showGetXToast(title: 'تنبيه', message: 'يرجى أختيار رقم العميل', toastColor: AppColors.mainColor1);
  //     return false;
  //   }

  //   return true;
  // }

  setOrderDetails() {
    clientNumberController.value.text = orderDetailsModel!.clientNumber!.toString();
    invoiceNumberController.value.text = orderDetailsModel!.invoiceNumber!.toString();
    categoriesNumberController.value.text = orderDetailsModel!.catsNumber!.toString();
    addressController.value.text = orderDetailsModel!.clientRegion! + ', ' + orderDetailsModel!.clientCity!;
    orderDetailsModel!.clientRegion! + ', ' + orderDetailsModel!.clientCity!;
    detailsController.value.text = orderDetailsModel!.details ?? 'لا توجد تفاصيل';
    boxNumberController.value.text = orderDetailsModel!.boxNumber.toString();
  }

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    getOrderById();
    //setStatus(Status.LOADING);
    // getDelegationById();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
