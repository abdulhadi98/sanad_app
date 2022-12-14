import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../helper/enums.dart';

class DeliverToClientController extends GetxController {
  Rx<Status>? status = Status.DATA.obs;

  OrderModel? orderModel;
  setStatus(Status s) {
    status!.value = s;
  }

  orderIsStamped() async {
    dynamic response;
    setStatus(Status.LOADING);

    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.billIsStamped,
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

  Rx<File>? selectedImage = File('null').obs;
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 30,
      // rotate: 180,
    );
    print('compressed');

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      var imageTemp = File(image.path);
      imageTemp = await testCompressAndGetFile(imageTemp, imageTemp.path + 'compressed.jpg');

      selectedImage!.value = imageTemp;
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  printX() {
    List<int> imageBytes = selectedImage!.value.readAsBytesSync();
    // print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
  }

  uploadBillImage() async {
    dynamic response;
    setStatus(Status.LOADING);
    List<int> imageBytes = selectedImage!.value.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);

    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.addImage,
        ),
        body: {'order_id': Get.arguments['order_id'].toString(), 'type': 'bill', 'image': base64Image},
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

  orderNotStamped() async {
    dynamic response;
    setStatus(Status.LOADING);
    print(UrlsContainer.billNotStamped);
    print(Get.arguments['order_id'].toString());
    try {
      //  print(orderModel!.toJson());
      String? token = await sharedPreferences!.getString("token");
      response = await http.post(
        Uri.parse(
          UrlsContainer.billNotStamped,
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
