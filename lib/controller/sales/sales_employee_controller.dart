import 'dart:convert';

import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';

import 'package:wits_app/model/sales_empolyee_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class SalesEmployeeController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  int? employeeId;
  List<SalesEmployeeModel> salesEmployeesList = [];
  getSalesEmployees() async {
    salesEmployeesList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(
          Uri.parse(UrlsContainer.getSalesEmployees),
          headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(response.body);
      List<dynamic> data = body['data']; //body['data']
      salesEmployeesList = List<SalesEmployeeModel>.from(
          data.map((x) => SalesEmployeeModel.fromJson(x)).toList());
      setStatus(Status.DATA);
      String code = body['code'].toString();
      String message = body['message'];
      Utils.getResponseCode(code, message);
      return 'code';
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
}
