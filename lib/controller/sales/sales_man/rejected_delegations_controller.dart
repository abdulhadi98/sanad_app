import 'dart:convert';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/delegation_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';

class RejectedDelegationsController extends GetxController {
  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  List<DelegationModel> delegationsList = [];

  // getDelegationId() {
  //   return delegationId;
  // }

  getDelegations() async {
    delegationsList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getRejectedDelegations), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(body);
      List<dynamic> data = body['data'];
      delegationsList = List<DelegationModel>.from(data.map((x) => DelegationModel.fromJson(x)).toList());
      //  delegationsList.removeWhere((delegation) => delegation.employeeId != null);
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

  @override
  void onInit() {
    getDelegations();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
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
