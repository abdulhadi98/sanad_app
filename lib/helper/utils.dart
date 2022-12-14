import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:wave_flutter/local/app_local.dart';
//import 'package:wave_flutter/storage/data_store.dart';
import 'package:collection/collection.dart';
import 'package:wits_app/main.dart';
import 'dart:ui' as ui;
import 'app_colors.dart';

class Utils {
  static Widget buildImage({required String? url, double? width, double? height, BoxFit fit = BoxFit.contain, Color? color}) {
    Widget assetImage(
      resPath,
    ) {
      return Image.asset(
        resPath,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (url == null || url == '') {
      return assetImage(
        'assets/images/placeholder.jpg',
      );
    }
    if (url.endsWith("svg")) {
      return SvgPicture.asset(
        url,
        color: color ?? Colors.white,
        height: height,
        width: width,
      );
    }
    if (url.startsWith("http")) {
      return FadeInImage.assetNetwork(
        imageErrorBuilder: (context, error, stackTrace) => assetImage(
          'assets/icons/placeholder.svg',
        ),
        placeholder: 'assets/icons/placeholder.svg',
        image: url,
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return assetImage(url);
    }
  }

  static getDelegationCreator(creatorId) {
    switch (creatorId) {
      case '6':
        return 'مدير المبيعات';
      case '21':
        return 'المدير العام';
      case '23':
        return 'مسؤول التحكم';
      case '8':
        return 'مندوب المبيعات';

      default:
    }
  }

  static getImagesFromGallery({onData, onError}) async {
    try {
      var picker = ImagePicker();
      List<XFile>? images = await picker.pickMultiImage();
      onData(images);
    } catch (e) {
      print(e);
      onError();
    }
  }

  // static Future getImageFromCamera({onData, onError}) async {
  //   try {
  //     if (await permissionHandler.Permission.camera.request().isGranted) {
  //       var picker = ImagePicker();
  //       PickedFile file = await picker.getImage(source: ImageSource.camera);
  //       onData(file);
  //     }
  //   } catch (e) {
  //     print(e);
  //     onError();
  //   }
  // }

  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
    );
  }

  Widget SU = ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Text('asdsa');
      });

  static String getRouteFromRole() {
    int? roleID = sharedPreferences!.getInt('role');
    switch (roleID) {
      case 1:
        return '/admin-root-screen';

      case 2:
        return '/driver-root-screen';

      case 3:
        return '/salesman-root-screen-new';
      case 4:
        return '/sales-employee-root-screen';
      case 5:
        return '/sales-manger-root-screen';
      case 6:
        return '/movment-manger-root-screen';
      case 7:
        return '/warehouse-manger-root-screen';
      case 8:
        return '/prepertion-worker-root-screen';
      case 9:
        return '/incpection-officer-root-screen';
      case 10:
        return '/quality-supervisor-root-screen';
      case 11:
        return '/general-manager-root-screen';
      case 13:
        return '/super-manager-root-screen';
      case 17:
        return '/return-manger-root-screen';
      default:
        'null';
    }
    return '??';
  }

  static Future<bool> isThisRoleManager() async {
    var roleId = await sharedPreferences!.getInt('role');
    print(roleId);
    if (roleId == 2 || roleId == 3 || roleId == 4 || roleId == 8) return false;
    return true;
  }

  static bool getApiFromRole() {
    var roleId = sharedPreferences!.getInt('role');
    if (roleId == 2 || roleId == 3 || roleId == 4 || roleId == 8) return false;
    return true;
  }

  static String getRouteFromNotificationOrder(action) {
    if (action == 'print')
      return '/print-order-movament-manger-screen';
    else if (action == 'assign-pre')
      return '/assign-perperator-screen';
    else if (action == 'rejected-stamp')
      return '/not-stamped-bill-screen';
    else if (action == 'pre-done')
      return '/preparation-done-screen';
    else if (action == 'enter-boxes')
      return '/enter-boxes-number-screen';
    else if (action == 'assign-driver')
      return '/assign-driver-screen';
    else if (action == 'recive-order')
      return '/load-will-delivered-screen';
    else if (action == 'deliver-to-another-driver')
      return '/recive-from-another-driver-screen';
    else if (action == 'quality-check')
      return '/check-order-screen';
    else if (action == 'returns-recived')
      return '/recive-returns-screen'; //TODO return id
    else if (action == 'order-from-sales-man')
      return '/order-from-salesperson-screen';
    else if (action == 'recive-order') return '/load-will-delivered-screen';
    // else if (action == 'deliver-to-another-driver') return '/';

    return '/';
  }

  static String getRouteFromNotificationDelegation(action) {
    if (action == 'info') //firas
      return 'ok';
    else if (action == 'rejected-dele') //firas
      return 'ok';
    else if (action == 'order-from-sales-manager')
      return '/add-order-from-delegation-sales-employee-screen';
    else if (action == 'order-from-sales-man') return '/order-from-salesperson-screen';

    return '/';
  }

  static Text errorText({String text = "يوجد خطأ, يرجى المحاولة لاحقاً"}) {
    return Text(
      text,
      textDirection: ui.TextDirection.rtl,
      style: TextStyle(color: AppColors.mainColor1, fontSize: 18.sp, fontWeight: FontWeight.normal, fontFamily: ('Bahij')),
    );
  }

  static void getResponseCode(String? code, String? message, {Function? onData}) {
    if (code == '200' && onData != null)
      onData();
    else if (code == '777')
      Utils.showGetXToast(title: 'تنبيه', message: message, toastColor: AppColors.red);
    else if (code != '200') Utils.showGetXToast(title: 'خطأ', message: 'حدث خطأ, يرجى المحاولة لاحقاً', toastColor: AppColors.red);
  }

  static void showGetXToast({String? title, String? message, Color? toastColor, Color textColor = Colors.black}) {
    Get.snackbar("", '',
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 0,
        backgroundColor: toastColor!.withOpacity(0.2),
        messageText: Text(
          message!,
          textDirection: ui.TextDirection.rtl,
          style: TextStyle(color: textColor.withOpacity(0.75), fontSize: 16.sp, fontWeight: FontWeight.normal, fontFamily: ('Bahij')),
        ),
        titleText: Text(
          title!,
          textDirection: ui.TextDirection.rtl,
          style: TextStyle(
            color: textColor.withOpacity(0.75),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: ('Bahij'),
          ),
        ),
        //maxWidth: ,
        barBlur: 3,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        duration: Duration(milliseconds: 2000)
        // icon: Image.asset(
        //   "assets/images/success_toast.png",
        //   height: 25,
        //   width: 25,
        //   color: Colors.white,
        // ),
        );
  }

  // static void showTranslatedToast(context, String text) {
  //   Fluttertoast.showToast(
  //     msg: AppLocalizations.of(context).trans(text),
  //   );
  // }

  static String enumToString<T>(T o) => o.toString().split('.').last;
  static T? enumFromString<T>(String key, List<T> values) => values.firstWhereOrNull(
        (v) => key == enumToString(v!),
      );
  static int getEnumItemIndex<T>(Object o, List<T> values) => values.indexWhere((element) => element == o);
  static T getEnum<T>(int index, List<T> values) => values[index];

  static String getDateTimeValue(Locale local, String timeStamp) {
    try {
      final dateTime = DateTime.parse(timeStamp);
      final format = DateFormat.yMMMd(local.languageCode);
      return format.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String getDateTimeSignUpFormat(Locale local) {
    try {
      final format = DateFormat.yMd(local.languageCode);
      return format.format(DateTime.now());
    } catch (e) {
      return '';
    }
  }

  static Future<String> formatProcessDate(date) async {
    if (date == 'null') return '';
    await initializeDateFormatting("ar_SA", '');
    // var now = orderDetailsController.orderDetailsModel!.processes!.first.createdAt;
    //    print(Utils.convertToArabicNumber(now!.hour.toString()));
    var formatter = DateFormat.yMMMMd('ar_SA');
    String formatted = formatter.format(date);
    print(formatted);
    return formatted;
  }

  static String formatProcessTime(DateTime date) {
    var dateTime = DateFormat('hh:mm a').format(date);
    var x = convertToArabicNumber(dateTime);
    print(x);
    return x;
  }

  static String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    number = number.replaceFirst('PM', 'مساءً ');
    number = number.replaceFirst('AM', 'صباحاً');
    print(number);
    number.characters.forEach((element) {
      var check = int.tryParse(element);

      check == null ? res += element : res += arabics[int.parse(element)];
    });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
    return res;
  }

  static String getFormattedCount(var count) {
    if (count < 9999)
      return count.toString();
    else if (count >= 9999 && count < 99999)
      return count.toString().substring(0, 1) + ' K';
    else
      return count.toString().substring(0, 2) + ' K';
  }

  static launchURL(myUrl) async {
    await launchURL(myUrl);
    // await launch(myUrl);
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    try {
      print(googleUrl);
      await launch(googleUrl);
    } catch (e) {
      print(e.toString());
    }
  }

  static bool isExist(value) {
    return value != null && value != "";
  }

  // static bool isLoggedUserExist() =>
  //     (GetIt.I<DataStore>().userModel?.apiToken) != null;

  // static bool isNotUserLogged() =>
  //     (GetIt.I<DataStore>().userModel?.apiToken) == null;

  static removeNullMapObjects(Map map) {
    map.removeWhere((key, value) => key == null || value == null);
  }

  static T? findItemById<T>(List? list, id) {
    try {
      return list?.firstWhereOrNull(
        (element) => element.id.toString() == id.toString(),
      );
    } catch (e) {
      return null;
    }
  }

  static String convertFileToBase64(String path) {
    File file = File(path);
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  static String getFormattedChartNum(num) {
    num = num ?? 0.0;
    String strNum = num.toString();
    if (strNum.contains('.')) {
      double d = double.parse(strNum);
      String formattedNum = NumberFormat('###,###.00').format(d);
      if (formattedNum.startsWith('.')) formattedNum = '0' + formattedNum;
      if (formattedNum.split('.').last == '00')
        return formattedNum.split('.').first;
      else
        return formattedNum;
    }
    int i = int.parse(strNum);
    String formattedNum = NumberFormat('###,###').format(i);
    return formattedNum;
  }

  static String getFormattedNum(num) {
    num = num ?? 0.0;
    String strNum = num.toString();
    if (strNum.contains('.')) {
      double d = double.parse(strNum);
      String formattedNum = NumberFormat('###,###.00').format(d);
      if (formattedNum.startsWith('.')) formattedNum = '0' + formattedNum;
      if (formattedNum.split('.').last == '00')
        return formattedNum.split('.').first;
      else
        return formattedNum;
    }
    int i = int.parse(strNum);
    String formattedNum = NumberFormat('###,###').format(i);
    return formattedNum;
  }

  static String getDoubleVal(strNum) {
    return strNum;
  }

  static String getFormattedStrNum(strNum) {
    if (strNum == null || strNum == 'null') strNum = 0.0;
    //  String strNum = num.toString();
    strNum = strNum.toString();
    if (strNum.contains('.')) {
      double d = double.parse(strNum);
      String formattedNum = NumberFormat('###,###.00').format(d);
      if (formattedNum.startsWith('.')) formattedNum = '0' + formattedNum;
      if (formattedNum.split('.').last == '00')
        return formattedNum.split('.').first;
      else
        return formattedNum;
    }
    int i = int.parse(strNum);
    String formattedNum = NumberFormat('###,###').format(i);
    return formattedNum;
  }
}
