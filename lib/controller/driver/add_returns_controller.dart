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
import 'package:wits_app/model/client_model.dart';
import 'package:wits_app/model/diver_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';
import 'package:flutter/services.dart';

class AddReturnsController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;
  Rx<TextEditingController> clientNumberController = TextEditingController().obs;

  Rx<TextEditingController> returnsDetailsController = TextEditingController().obs;

  List<ClientModel> clientsList = [];
  getClientsInfo() async {
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

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  addReturns() async {
    dynamic response;
    setStatus(Status.LOADING);
    print(pathsList.length);
    try {
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.addReturns,
        ),
        body: {'details': returnsDetailsController.value.text, "client_number": clientNumberController.value.text, 'images': jsonEncode(pathsList)},
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
      setStatus(Status.DATA);
      Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
      return 'error';
    }
  }

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
    if (clientNumberController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى اختيار رقم العميل', toastColor: AppColors.red);
      return false;
    }
    if (returnsDetailsController.value.text.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى إدخال تفاصيل المرتجعات', toastColor: AppColors.red);
      return false;
    }
    if (selectedImages.isEmpty) {
      Utils.showGetXToast(title: 'تنبيه', message: 'يرجى تصوير المرتجعات', toastColor: AppColors.red);
      return false;
    }
    return true;
  }

  RxList<File> selectedImages = <File>[].obs;
  List<String> pathsList = [];
  // uploadReturnsImages() async {
  //   try {
  //     for (int i = 0; i < selectedImages.length; i++) {
  //       var x = await uploadSingleImage(selectedImages[i]);
  //       print(selectedImages[i].path + ' ' + 'is uploaded');
  //     }
  //     // selectedImages.forEach((element) async {
  //     //   c++;
  //     // });
  //     return 'ok';
  //   } catch (e) {
  //     print(e);
  //     Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
  //     return;
  //   }
  // }

  uploadReturnsImagesPaths() async {
    pathsList.clear();

    try {
      for (int i = 0; i < selectedImages.length; i++) {
        List<int> imageBytes = selectedImages[i].readAsBytesSync();
        //  print(imageBytes);
        String base64Image = base64Encode(imageBytes);
        pathsList.add(base64Image);
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

  // uploadSingleImage(File singleImage) async {
  //   dynamic response;
  //   setStatus(Status.LOADING);
  //   List<int> imageBytes = singleImage.readAsBytesSync();
  //   //  print(imageBytes);
  //   String base64Image = base64Encode(imageBytes);

  //   try {
  //     //  print(orderModel!.toJson());
  //     String? token = await sharedPreferences!.getString("token");
  //     response = await http.post(
  //       Uri.parse(
  //         UrlsContainer.addImage,
  //       ),
  //       body: {
  //         'order_id': '1', //TODO change order id to returns id
  //         'type': 'returns',
  //         'image': base64Image,
  //       },
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     dynamic body = jsonDecode(response.body);
  //     print(body);
  //     String code = body['code'].toString();
  //     String message = body['message'];
  //     Utils.getResponseCode(code, message);
  //     setStatus(Status.DATA);
  //     return code;
  //   } catch (e) {
  //     print(e);
  //     setStatus(Status.ERROR);
  //     Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ غير متوقع, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
  //     return 'error';
  //   }
  // }

  @override
  void onInit() {
    // getDrivers();
    //addressController.value.text = 'address';
    getClientsInfo();
    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
