import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wits_app/view/common_wigets/textfield_custom.dart';

class SearchField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String hint;
  final bool? enabled;
  final TextEditingController? textEditingController;
  final bool? isPassword;
  final double? height;
  final double? width;
  final Function() onSearchPressed;

  final Function(String) onChanged;
  final dynamic onError;
  TextDirection? textDirection;
  SearchField({
   required this.onSearchPressed,
    this.height,
    this.width,
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
        width: width ?? 295.w,
        height: height ?? 50.h,
        child: TextField(
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: isPassword ?? false,
          enabled: enabled ?? true,
          // textAlignVertical: TextAlignVertical.bottom,
          onChanged: onChanged,
          style: TextStyle(
            color: AppColors.black.withOpacity(.70),
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
          controller: textEditingController,
          decoration: searchDecoration(hint),
        ),
      ),
    );
  }

  InputDecoration searchDecoration(hint) => InputDecoration(
        suffixIcon: InkWell(
            onTap: onSearchPressed,
            child: Padding(
              padding: EdgeInsets.only(bottom: 14.0.h, left: 13.w, top: 14.w),
              child: SvgPicture.asset(
                'assets/icons/Icon Search Dark.svg',
                width: 17.w,
              ),
            )),

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
}
