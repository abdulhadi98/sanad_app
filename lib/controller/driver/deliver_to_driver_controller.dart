import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/diver_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class DeliverToDriverController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  changeDriver() async {
    dynamic response;
    setStatus(Status.LOADING);
    var x = {'order_id': Get.arguments['order_id'].toString(), 'driver_id': driverId.toString(), 'location': postion.latitude.toString() + ',' + postion.longitude.toString()};
    print(x.toString());
    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.changeDriver,
        ),
        body: {'order_id': Get.arguments['order_id'].toString(), 'driver_id': driverId.toString(), 'location': postion.latitude.toString() + ',' + postion.longitude.toString()},
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
      return code;
    } catch (e) {
      print(e);
      setStatus(Status.ERROR);
      // spinner.value = false;
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

  RxList<File> selectedImages = <File>[].obs;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      selectedImages.add(imageTemp);
      // selectedImages.value = imageTemp;
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  bool validate() {
    if (driverId == null) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار السائق الآخر', toastColor: AppColors.red);
      return false;
    }
    if (postion == null) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تحديد الموقع', toastColor: AppColors.red);
      return false;
    }
    if (selectedImages.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تصوير سيارة السائق الآخر', toastColor: AppColors.red);
      return false;
    }

    return true;
  }

  uploadDriverTruckImages() async {
    try {
      for (int i = 0; i < selectedImages.length; i++) {
        var x = await uploadSingleTruckImage(selectedImages[i]);
        print(selectedImages[i].path + ' ' + 'is uploaded');
      }
      // selectedImages.forEach((element) async {
      //   c++;
      // });
      return 'ok';
    } catch (e) {
      print(e);
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return;
    }
  }

  uploadSingleTruckImage(File singleImage) async {
    dynamic response;
    setStatus(Status.LOADING);
    List<int> imageBytes = singleImage.readAsBytesSync();
    //  print(imageBytes);
    String base64Image = base64Encode(imageBytes);

    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.addImage,
        ),
        body: {
          'order_id': Get.arguments['order_id'].toString(),
          'type': 'truck',
          'image': base64Image,
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

  RxBool locationSpinner = false.obs;
  var postion;
  Future<Position> determinePosition() async {
    locationSpinner.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تشغيل خدمة الموقع', toastColor: AppColors.orange);
      locationSpinner.value = false;

      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showGetXToast(title: 'تنبيه', message: 'لا توجد صلاحية للوصول للموقع', toastColor: AppColors.orange);
        locationSpinner.value = false;

        return Future.error('Location permissions are denied');
      }
      locationSpinner.value = false;
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Utils.showGetXToast(title: 'تنبيه', message: 'لقد تم رفض صلاحية الوصول للموقع نهائياً', toastColor: AppColors.orange);
      locationSpinner.value = false;

      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    postion = await Geolocator.getCurrentPosition().whenComplete(() {
      locationSpinner.value = false;
      Utils.showGetXToast(title: 'تنبيه', message: ' تم تحديد الموقع بنجاح', toastColor: Colors.green);
    });

    return postion;
  }

  @override
  void onInit() {
    getDrivers();
    //addressController.value.text = 'address';
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
