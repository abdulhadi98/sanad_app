import 'dart:convert';

import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/diver_model.dart';
import 'package:wits_app/model/preperator_model.dart';

import 'package:wits_app/model/sales_empolyee_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../helper/enums.dart';

class PerperatorController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  int? preparatorId;
  List<PerperatorModel> preparatorsList = [];
  getPreparators() async {
    preparatorsList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
     try {
    dynamic response = await http.get(Uri.parse(UrlsContainer.getPerperators), headers: {'Authorization': 'Bearer $token'});
    dynamic body = jsonDecode(response.body);
    print(response.body);
    List<dynamic> data = body['data']; //body['data']
    preparatorsList = List<PerperatorModel>.from(data.map((x) => PerperatorModel.fromJson(x)).toList());

    String code = body['code'].toString();
    String message = body['message'];
    Utils.getResponseCode(code, message);

    setStatus(Status.DATA);
    return 'code';
  } catch (e) {
    print(e);
    setStatus(Status.ERROR);
    // spinner.value = false;
    Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
    return 'error';
  }
  }

  assignPerperator() async {
    dynamic response;
    print(OrdersRootScreen.orderId.toString() + '  ' + preparatorId.toString() + ' ' + UrlsContainer.assignPerperator);
    setStatus(Status.LOADING);
    try {
      // print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.assignPerperator,
          ),
          body: {'order_id': OrdersRootScreen.orderId.toString(), 'preparator_id': preparatorId.toString()},
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
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
