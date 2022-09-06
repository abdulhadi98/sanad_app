import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';

class AddNewOrderFromDelegationScreenController extends GetxController {
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
      setStatus(Status.DATA);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  var returnOrderID;
  addNewOrder() async {
    dynamic response;
    setStatus(Status.LOADING);
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
      returnOrderID = body['data']['id'].toString();

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

  addOrderIdToDelegation() async {
    dynamic response;
    setStatus(Status.LOADING);
    try {
      // print(UrlsContainer.addOrderIdToDelegation + ' ' + returnsOrderId.toString() + ' ' + Get.arguments['delegation_id'].toString());
      // print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" + returnsOrderId.toString());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addOrderIdToDelegation,
          ),
          body: {'order_id': returnOrderID.toString(), 'delegation_id': Get.arguments['delegation_id'].toString()},
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

  bool validateInputs() {
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

  setOrderModel({String? details, String? clientNumber, salesmanId}) async {
    print(await sharedPreferences!.getInt('user_id').toString());
    addressController.value.text = clientsList.firstWhere((element) => element.clientNumber.toString() == clientNumber).cityName.toString() +
        ', ' +
        clientsList.firstWhere((element) => element.clientNumber.toString() == clientNumber).regionName.toString();
    print(clientsList.first.clientNumber);
    print(clientNumberController.value.text);
    orderModel = OrderModel(
      clientNumber: clientNumber,
      creatorId: salesmanId, //it's not the sales manger id but the sales man id that create the order
      commercialRecord: clientNumberController.value.text,
      address: addressController.value.text,
      invoiceNumber: invoiceNumberController.value.text,
      categoriesNumber: categoriesNumberController.value.text,
      details: details == null ? 'لايوجد تفاصيل' : details,
    );
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
