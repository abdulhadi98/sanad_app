import 'dart:convert';

import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/diver_model.dart';

import 'package:wits_app/model/sales_empolyee_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import '../../helper/enums.dart';

class DriversController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  int? driverId;
  List<DriverModel> driversList = [];
  getDrivers() async {
    driversList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getDrivers), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(response.body);
      List<dynamic> data = body['data']; //body['data']
      driversList = List<DriverModel>.from(data.map((x) => DriverModel.fromJson(x)).toList());

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

  RxString driverName = ''.obs;
  setDriverName(int driverId) {
    driverName.value = driversList.firstWhere((element) => element.id == driverId).name!;
  }

  assignDriver() async {
    dynamic response;
    print(OrdersRootScreen.orderId.toString() + '  ' + driverId.toString() + ' ' + UrlsContainer.assignDriver);
    setStatus(Status.LOADING);
    try {
      // print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.assignDriver,
          ),
          body: {'order_id': OrdersRootScreen.orderId.toString(), 'driver_id': driverId.toString()},
          headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      String code = body['code'].toString();
      String message = body['message'];

      Utils.getResponseCode(code, message, onData: () {
        Get.offAllNamed('/movment-manger-root-screen');
      });
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
    //   getDrivers();
    super.onInit();
  }
}
