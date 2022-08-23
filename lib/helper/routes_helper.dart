import 'package:flutter/material.dart';
//import 'package:wave_flutter/models/image_model.dart';
//import 'package:wave_flutter/ui/root/gallery_full_screen.dart';

class RoutesHelper {
  static Future<dynamic> navigateTo(
      {required Widget classToNavigate, required BuildContext context}) {
    return Navigator.of(context).push<dynamic>(PageRouteBuilder<dynamic>(
      pageBuilder:
          (BuildContext c, Animation<double> a1, Animation<double> a2) =>
              classToNavigate,
      maintainState: true,
      barrierDismissible: true,
      opaque: true,
      transitionsBuilder: (BuildContext c, Animation<double> anim,
              Animation<double> a2, Widget child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 0),
    ));
  }

  static void navigateReplacementTo(
      {required Widget classToNavigate, required BuildContext context}) {
    Navigator.of(context).pushReplacement(PageRouteBuilder<dynamic>(
      pageBuilder:
          (BuildContext c, Animation<double> a1, Animation<double> a2) =>
              classToNavigate,
      maintainState: true,
      barrierDismissible: true,
      opaque: true,
      transitionsBuilder: (BuildContext c, Animation<double> anim,
              Animation<double> a2, Widget child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 0),
    ));
  }

  // static void navigateToGalleryScreen(
  //     {required List<String> gallery, index, required BuildContext context}) {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       transitionsBuilder: (c, anim, a2, child) =>
  //           FadeTransition(opacity: anim, child: child),
  //       transitionDuration: Duration(milliseconds: 200),
  //       opaque: false, // set to false
  //       pageBuilder: (_, __, ___) =>
  //           GalleryFullScreen(gallery, initialIndex: index),
  //     ),
  //   );
  // }
}
