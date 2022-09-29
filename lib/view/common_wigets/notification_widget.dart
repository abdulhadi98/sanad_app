import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationWidget extends StatelessWidget {
  final String? title;
  //final String? clientNumber;
  final String mainColor;
  final String sideColor;
  final String type;

  final Function? onTap;
//  final Function() onTap;

  const NotificationWidget({
    Key? key,
    this.onTap,
    this.title,
    // this.clientNumber,
    required this.mainColor,
    required this.sideColor,
    required this.type,

    //  required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            onTap!();
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width,
                  height: 70.h,
                  color: Color(int.parse(mainColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!.length > 40 ? '...' + title!.substring(0, 40) : title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
