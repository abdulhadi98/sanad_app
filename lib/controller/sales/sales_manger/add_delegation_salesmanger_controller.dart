import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/client_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';
import '../../../model/delegation_model.dart';

class AddDelegationSalesMangerController extends GetxController {
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> detailsController = TextEditingController().obs;

  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  String? accessToken;

  setDelegationInfo({clienNumber, details}) {
    clientNumberController.value.text = clienNumber;
    detailsController.value.text = details;
  }

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
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  addDelegationManger() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      print(delegationModel!
          .toJsonMangerFromScratch()); //warehouse id not requaired in salesmanger and general manager but we added it to the delegation model for super manager (addDelegationSuperManger).
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addDelegationManger,
          ),
          body: delegationModel!.toJsonMangerFromScratch(), //This one for adding delegation from the start(from the sales manger root screen -assign sales employee- and it doesn't need delegation id)
          headers: {'Authorization': 'Bearer $token'});

      dynamic body = jsonDecode(response.body);
      print(body);
      String code = body['code'].toString();
      String message = body['message'];
      setStatus(Status.DATA);

      Utils.getResponseCode(code, message, onData: () {
        employeeId = null;
      });
      employeeId = null;
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  addDelegationSuperManger() async {
    dynamic response;
    spinner.value = true;
    try {
      print(delegationModel!.toJsonMangerFromScratch());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addDelegationSuperManager, //here we need warehouse id because super manager can manage all warehouses.
          ),
          body: delegationModel!.toJsonMangerFromScratch(), //This one for adding delegation from the start(from the sales manger root screen -assign sales employee- and it doesn't need delegation id)
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
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  bool validateInputs() {
    if (clientNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى أختيار رقم العميل', toastColor: AppColors.mainColor1);
      return false;
    }
    if (detailsController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال تفاصيل الطلبية', toastColor: AppColors.mainColor1);
      return false;
    }

    return true;
  }

  DelegationModel? delegationModel;

  setDelegation() async {
    delegationModel = DelegationModel(
      clientNumber: clientNumberController.value.text,
      creatorId: await sharedPreferences!.getInt('user_id').toString(),
      details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
    );
  }

  int? employeeId;
  setDelegationManger(int? employeeId) {
    delegationModel = DelegationModel(
        clientNumber: clientNumberController.value.text,
        creatorId: sharedPreferences!.getInt('user_id').toString(),
        details: detailsController.value.text.isEmpty ? ' ' : detailsController.value.text,
        employeeId: employeeId,
        warehouseId: sharedPreferences!.getInt('warehouse_id').toString());
  }

  @override
  void onInit() {
    getUsersInfo();
    //addressController.value.text = 'address';
    super.onInit();
    //  setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
