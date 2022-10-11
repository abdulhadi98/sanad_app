import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/app_colors.dart';

  class TextFieldCustom extends StatelessWidget {
    final TextInputType? keyboardType;
    final String hint;
    final bool? enabled;
    final TextEditingController? textEditingController;
    final bool? isPassword;

    final Function(String) onChanged;
    final dynamic onError;
    TextDirection? textDirection;
    TextFieldCustom({
      this.textDirection,
      this.isPassword,
      Key? key,
      this.keyboardType,
      required this.hint,
      required this.onChanged,
      this.onError,
      this.enabled,
      this.textEditingController,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Directionality(
        textDirection: textDirection ?? TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: enabled == null ? Colors.white : AppColors.background,
          ),
          width: 295.w,
          height: 50.h,
          child: TextField(
            keyboardType: keyboardType ?? TextInputType.text,
            obscureText: isPassword ?? false,
            enabled: enabled ?? true,
            textAlignVertical: TextAlignVertical.bottom,
            onChanged: onChanged,
            style: TextStyle(
              color: AppColors.black.withOpacity(.70),
              fontWeight: FontWeight.normal,
              fontSize: 15.sp,
            ),
            controller: textEditingController,
            decoration: enabled == false ? notEnabled(hint) : enabledK(hint),
        ),
      ),
    );
  }
}
  
InputDecoration enabledTall(hint) => InputDecoration(
      alignLabelWithHint: true,
      label: Text(
        hint,
        style: TextStyle(
          color: AppColors.mainColor1,
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      //  hintText: hint,
      // hintStyle: TextStyle(color: AppColors.brown.withOpacity(.30), fontSize: 14.sp, fontWeight: FontWeight.normal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
    );

InputDecoration enabledK(hint) => InputDecoration(
      label: Text(
        hint,
        style: TextStyle(
          color: AppColors.mainColor1,
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      //  hintText: hint,
      // hintStyle: TextStyle(color: AppColors.brown.withOpacity(.30), fontSize: 14.sp, fontWeight: FontWeight.normal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
    );

InputDecoration notEnabled(hint) => InputDecoration(
      label: Text(
        hint,
        style: TextStyle(
          color: AppColors.mainColor1,
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.brown.withOpacity(.30), fontSize: 14.sp, fontWeight: FontWeight.normal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
      ),
    );
InputDecoration inputDecoration = InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
  hintText: 'رقم العميل',
  hintStyle: TextStyle(
    color: AppColors.brown.withOpacity(.30),
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.r),
    borderSide: BorderSide(color: AppColors.mainColor1),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.r),
    borderSide: BorderSide(color: AppColors.mainColor1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.r),
    borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.r),
    borderSide: BorderSide(color: AppColors.mainColor1, width: 1.5),
  ),
);

class TextFieldTall extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hint;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  bool? enabled;
  double? height;

  TextFieldTall({
    Key? key,
    this.height,
    this.enabled,
    required this.hint,
    required this.onChanged,
    this.focusNode,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: enabled == null ? Colors.white : AppColors.background,
        ),
        width: 295.w,
        height: height ?? 185.h,
        child: TextField(
          controller: textEditingController,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          onChanged: onChanged,
          maxLines: null,
          focusNode: focusNode,
          enabled: enabled ?? true,
          style: TextStyle(color: AppColors.black.withOpacity(.70), fontSize: 14.sp),
          decoration: enabled == false ? notEnabled(hint) : enabledTall(hint),
        ),
      ),
    );
  }
}
