import 'dart:convert';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class CheckOrderController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

    accecptStampedBill() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.accecptStampedBill,
        ),
        body: {
          'order_id': Get.arguments['order_id'].toString(),
        },
        headers: {'Authorization': 'Bearer $token'},
      );
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

 
 
  rejectStampedBill() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.rejectStampedBill,
        ),
        body: {
          'order_id': Get.arguments['order_id'].toString(),
        },
        headers: {'Authorization': 'Bearer $token'},
      );
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
    // getOrderById();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
