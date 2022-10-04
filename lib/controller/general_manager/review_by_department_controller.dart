import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/diver_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/model/role_model.dart';
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class ReviewByDepartmentController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  Rx<TextEditingController> reviewController = TextEditingController().obs;

  int? orderId;

  addReview() async {
    dynamic response;
    setStatus(Status.LOADING);
    try {
      // print(UrlsContainer.addOrderIdToDelegation + ' ' + returnsOrderId.toString() + ' ' + Get.arguments['delegation_id'].toString());
      // print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" + returnsOrderId.toString());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
          Uri.parse(
            UrlsContainer.addReviewByRole,
          ),
          body: {'role_id': roleId.toString(), 'employee_id': employeeId.toString(), 'note': reviewController.value.text},
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

  int? employeeId;
  List<RoleModel> rolesList = [];
  RxBool employeesSpinner = false.obs;

  int? roleId;
  getDepartments() async {
    rolesList.clear();
    String? token = await sharedPreferences!.getString("token");
    setStatus(Status.LOADING);
    try {
      dynamic response = await http.get(Uri.parse(UrlsContainer.getRoles), headers: {'Authorization': 'Bearer $token'});
      dynamic body = jsonDecode(response.body);
      print(response.body);
      List<dynamic> data = body['data']; //body['data']
      rolesList = List<RoleModel>.from(data.map((x) => RoleModel.fromJson(x)).toList());

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

  List<DriverModel> employeeList = [];
  getEmployeesByDepartment() async {
    employeeList.clear();
    print(employeesSpinner.value);
    print(UrlsContainer.getEmployeesByRole + '?role_id=$roleId');

    String? token = await sharedPreferences!.getString("token");
    employeesSpinner.value = true;
    print(employeesSpinner.value);
    //  try {
    dynamic response = await http.get(Uri.parse(UrlsContainer.getEmployeesByRole + '?role_id=$roleId'), headers: {'Authorization': 'Bearer $token'});
    dynamic body = jsonDecode(response.body);
    print(response.body);
    List<dynamic> data = body['data']; //body['data']
    employeeList = List<DriverModel>.from(data.map((x) => DriverModel.fromJson(x)).toList());

    String code = body['code'].toString();
    String message = body['message'];
    Utils.getResponseCode(code, message);
    employeesSpinner = false.obs;
    print(employeesSpinner.value);

    return code;
    // } catch (e) {
    //   print(e);
    //   employeesSpinner = false.obs;
    //   // spinner.value = false;
    //   Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
    //   return 'error';
    // }
  }

  RxString employeeName = ''.obs;
  setEmployeeName(int empId) {
    employeeName.value = employeeList.firstWhere((element) => element.id == empId).name!;
  }
  RxString departmentName = ''.obs;
  setDepartmentName(int departmentId) {
    departmentName.value = rolesList.firstWhere((element) => element.id == departmentId).role!;
  }

  getEmployeesByDepartmentWithWareHouse() async {
    employeeList.clear();
    print(employeesSpinner.value);
    int? warehouseId = await sharedPreferences!.getInt("warehouse_id");
    print(UrlsContainer.getEmployeesByRoleSuper + '?role_id=$roleId' + '&?warehouse_id=$warehouseId');

    String? token = await sharedPreferences!.getString("token");

    employeesSpinner.value = true;
    print(employeesSpinner.value);
    //  try {
    dynamic response = await http.get(Uri.parse(UrlsContainer.getEmployeesByRoleSuper + '?role_id=$roleId' + '&warehouse_id=$warehouseId'), headers: {'Authorization': 'Bearer $token'});
    dynamic body = jsonDecode(response.body);
    print(response.body);
    var data = body['data']; //body['data']
    employeeList = List<DriverModel>.from(data.map((x) => DriverModel.fromJson(x)).toList());

    String code = body['code'].toString();
    String message = body['message'];
    Utils.getResponseCode(code, message);
    employeesSpinner = false.obs;
    print(employeesSpinner.value);

    return code;
    // } catch (e) {
    //   print(e);
    //   employeesSpinner = false.obs;
    //   // spinner.value = false;
    //   Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
    //   return 'error';
    // }
  }

  bool validate() {
    if (roleId == null) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار القسم', toastColor: AppColors.red);
      return false;
    }
    if (employeeId == null) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار الموظف', toastColor: AppColors.red);
      return false;
    }
    if (reviewController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى كتابة ملاحظة', toastColor: AppColors.red);
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    getDepartments();
    // getDrivers();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
