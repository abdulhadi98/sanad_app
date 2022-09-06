import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/app_colors.dart';
import '../../helper/app_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  double? height;
  final double width;
  final Color? color;
  final Function() onPressed;
  MainButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: color == null ? AppColors.mainColor1.withOpacity(0.5) : color!.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
          
          splashColor: color == null ? AppColors.mainColor2.withOpacity(0.5) : Colors.redAccent[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          color: color == null ? AppColors.mainColor1 : color,
          minWidth: width,
          height: height,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, letterSpacing: 0),
          ),
          textColor: Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
