import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wits_app/helper/app_colors.dart';

showDialogCustom({
  required context,
  required padding,
  required Widget dialogContent,
  required height,
  required width,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          //  color: AppColors.white.withOpacity(0.1),
          height: height,
          width: width,
          child: Dialog(
            backgroundColor: Colors.white.withOpacity(.8),
            insetPadding: padding,
            child: dialogContent,
          ),
        ),
      );
    },
  );
}
