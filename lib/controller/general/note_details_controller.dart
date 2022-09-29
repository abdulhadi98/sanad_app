import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/helper/utils.dart';
import 'package:wits_app/main.dart';
import 'package:wits_app/model/note_model.dart';
import 'package:wits_app/model/notification_model.dart';
import 'package:wits_app/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:wits_app/network/urls_container.dart';
import '../../../helper/enums.dart';

class NoteDetailsController extends GetxController {
  RxBool spinner = false.obs;
  Rx<Status>? status = Status.DATA.obs;
  setStatus(Status s) {
    status!.value = s;
  }

  TextEditingController noteController = TextEditingController();
  NoteModel? noteModel;
  List<NoteModel> notesList = [];
  getNoteById() async {
    setStatus(Status.LOADING);
    print('note_id=${Get.arguments['note_id']}');
    String? token = await sharedPreferences!.getString("token");
     try {
    dynamic response = await http.get(Uri.parse(UrlsContainer.getReviewsById + '?review_id=${Get.arguments['note_id']}'), headers: {'Authorization': 'Bearer $token'});
    dynamic body = jsonDecode(response.body);
    print(body);
    //List<dynamic> data = body['data'];
    var data = body['data'];
    noteModel = NoteModel.fromJson(data);

    setNoteInfo();
    //print(OrderDetailsModel.fromJson(data));

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

  RxString managerName = ''.obs;
  setNoteInfo() {
    noteController.text = noteModel!.note!;
    managerName.value = noteModel!.managerName!;
  }

  @override
  void onInit() {
    //addressController.value.text = 'address';
    getNoteById();

    super.onInit();
    //setStatus(Status.LOADING);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
