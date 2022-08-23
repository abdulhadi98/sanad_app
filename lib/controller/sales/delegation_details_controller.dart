import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/delegation_model.dart';

import 'package:http/http.dart' as http;
import 'package:wits_app/model/order_model.dart';
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/sales/sales_manger/orders/order_from_salesperson_screen.dart';
import '../../helper/enums.dart';
import '../../view/sales/sales_manger/sales_manger_root_screen.dart';

class DelegationDetailsController extends GetxController {
  Rx<TextEditingController> clientNumberController =
      TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;
  Rx<TextEditingController> invoiceNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> categoriesNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  // setDelegationInfo({clienNumber, details}) {
  //   clientNumberController.value.text = clienNumber;
  //   detailsController.value.text = details;
  // }
  List<ClientModel> clientsList = [];

  Null employeeId;
  getUsersInfo() async {
    clientsList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getClientsInfo),
          headers: {'Authorization': 'Bearer $token'});
      Map body = jsonDecode(response.body);
      print(body);
      List<dynamic> data = body['data'];
      clientsList = List<ClientModel>.from(
          data.map((x) => ClientModel.fromJson(x)).toList());
      setStatus(Status.DATA);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(
          title: 'خطأ',
          message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
          toastColor: AppColors.red);
      return 'error';
    }
  }

  OrderModel? orderModel;
  setOrderModel() async {
    print(await sharedPreferences!.getInt('user_id').toString());
    addressController.value.text = clientsList
            .firstWhere((element) =>
                element.clientNumber.toString() ==
                clientNumberController.value.text)
            .regionName
            .toString() +
        ', ' +
        clientsList
            .firstWhere((element) =>
                element.clientNumber.toString() ==
                clientNumberController.value.text)
            .cityId
            .toString();
    print(clientsList.first.clientNumber);
    print(clientNumberController.value.text);
    orderModel = OrderModel(
      clientNumber: clientNumberController.value.text,
      creatorId: await sharedPreferences!.getInt('user_id'),
      commercialRecord: clientNumberController.value.text,
      address: addressController.value.text,
      invoiceNumber: invoiceNumberController.value.text,
      categoriesNumber: categoriesNumberController.value.text,
      details: detailsController.value.text.isEmpty
          ? ' '
          : detailsController.value.text,
    );
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
      Utils.showGetXToast(
          title: 'خطأ',
          message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
          toastColor: AppColors.red);
      return 'error';
    }
  }

  bool validateInputs() {
    if (clientNumberController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى أختيار رقم العميل',
          toastColor: AppColors.mainColor1);
      return false;
    }
    if (detailsController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى إدخال تفاصيل الطلبية',
          toastColor: AppColors.mainColor1);
      return false;
    }

    return true;
  }

  bool validateOrder() {
    if (clientNumberController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى أختيار رقم العميل',
          toastColor: AppColors.mainColor1);
      return false;
    }
    if (invoiceNumberController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى إدخال رقم الفاتورة',
          toastColor: AppColors.mainColor1);
      return false;
    }
    if (categoriesNumberController.value.text.isEmpty) {
      Utils.showGetXToast(
          title: 'تنبيه',
          message: 'يرجى إدخال عدد الأصناف',
          toastColor: AppColors.mainColor1);
      return false;
    }
    return true;
  }

  DelegationModel? delegationModel;

  setDelegation() async {
    delegationModel = DelegationModel(
      clientNumber: clientNumberController.value.text,
      creatorId: await sharedPreferences!.getInt('user_id').toString(),
      details: detailsController.value.text.isEmpty
          ? ' '
          : detailsController.value.text,
    );
  }

  addDelegationManger() async {
    dynamic response;
    spinner.value = true;
    
    try {
      print(delegationModel!.toJsonManger());
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

      Utils.getResponseCode(code, message, onData: () {
        employeeId = null;
      });
      employeeId = null;
      return code;
    } catch (e) {
      print(e);
      spinner.value = false;
      Utils.showGetXToast(
          title: 'خطأ',
          message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
          toastColor: AppColors.red);
      return 'error';
    }
  }

  setDelegationManger(int? employeeId) async {
    // print('employee id=$employeeId');
    // print(clientNumberController.value.text);
    // print(sharedPreferences!.getInt('user_id').toString());
    // print(detailsController.value.text);
    delegationModel = DelegationModel(
        clientNumber: clientNumberController.value.text,
        creatorId: await sharedPreferences!.getInt('user_id').toString(),
        details: detailsController.value.text.isEmpty
            ? ' '
            : detailsController.value.text,
        employeeId: SalesMangerRootScreen.salesmanId);
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
    int? id = SalesmanOrderScreen.delegationId;
    print('delegationId= #$id');
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(
          Uri.parse(UrlsContainer.getDelegationById + '?delegation_id=$id'),
          headers: {'Authorization': 'Bearer $token'});
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
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(
          title: 'خطأ',
          message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً',
          toastColor: AppColors.red);
      return 'error';
    }
  }

  setDelegationInfo() {
    print(delegationModel!.clientNumber.toString());
    print(delegationModel!.details.toString());

    clientNumberController.value.text =
        delegationModel!.clientNumber.toString();
    detailsController.value.text = delegationModel!.details!;
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
    // getDelegationById();
    getUsersInfo();
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
