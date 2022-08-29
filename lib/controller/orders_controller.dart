import 'dart:convert';

import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class OrdersController extends GetxController {
  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  List<OrderModel> ordersList = [];

  getOrders() async {
    ordersList.clear();
    String? token = await sharedPreferences!.getString("token");
    print(token);
    print(Uri.parse(UrlsContainer.baseApiUrl + Get.arguments['api']!));
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.baseApiUrl + Get.arguments['api']!), headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2JiMWYzY2Q5ZmUwOWVmNTU1MzBiZjQ3NDNkMmU4Y2U1MjNkYTg0MDNhNmQ0NmUyOWMzZGFlZTFjNTIyMWFhZGVmMzEzNjYwMDU2ZDAxYzYiLCJpYXQiOjE2NTkzNTczMzcsIm5iZiI6MTY1OTM1NzMzNywiZXhwIjoxNjkwODkzMzM3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.jrS6VF0-VfQ6ar8jzsQW7yLm3qZl7-TnhN1E9qI3_ETi0TQzwEOwyX5IlwRSFYppQ7EpLpewZHLhPN29zLCT8CMgKiHS2ECGHfsYCVgE5RKu7wxnF-_XUAIqUGns1DbyEf4W1Sbf7mZPZDSEolJ9l3cluqRkC0HCk5vjaMR_8ppIAGpH4_4ZFxxgOV4FpfQ90TEfOriwD3E_bz-3UVqapJ2mm89YIcak9DIgV-_5MEtZ14ltb9QvmbJGTUOsh07QsZC-xMpl_teSaPRIg9EBCNAxkjYuTpGYfEIXSNcnIVQ4i3hxYiPIlcA9tUgDZwQvhmIZdjU79W6Pb_UV9CH_rYUkyoVG7mX9oPcWvIeHqNPu60CU3-oLBg_HtSw6fJLUmR8srNR2Ny6pRq0AXeAybao8pi9Vi_4YxjPyU1mk5ax0BFPjXj3paDGQGSO42yKg3t_-jfSFAVN47Agaj_mI98652C57SxEVzz4nOIrun5XvkuQtV7Jg-fGt1B_vTwX4g-wsYc13M_BG5nmRMCLyQeMH3KZuPq3vsvMcl-m7ZP8O6BwfcuKOBdELi1Aqhn9m1dcrAAyczKP3uXfUxNgUA3ro847BNkW30FM90IgiDk3Kj0TzmLMcxeWqNg47pwFDCaWMyjTdactubW0HC90Boc-25VsS1hRtRcwqZXGr9YU'
      });
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

  addNewOrder() async {
    String? token = await sharedPreferences!.getString("token");
    dynamic response;
    spinner.value = true;
    try {
      response = await http.post(Uri.parse(UrlsContainer.getORders), headers: {'Authorization': 'Bearer $token'});
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

  @override
  void onInit() {
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
    getOrders();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
