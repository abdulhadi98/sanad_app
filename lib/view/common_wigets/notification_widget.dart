import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wits_app/helper/utils.dart';

class NotificationWidget extends StatelessWidget {
  final String? title;
  //final String? clientNumber;
  final String mainColor;
  final String sideColor;
  final String type;
  final DateTime? notificationDate;
  final Function? onTap;
//  final Function() onTap;

  const NotificationWidget({
    Key? key,
    this.onTap,
    this.title,
    this.notificationDate,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!.length > 40 ? '...' + title!.substring(0, 40) : title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<String>(
                            future: Utils.formatProcessDate(notificationDate ?? 'null'), // async work
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text('');
                                default:
                                  if (snapshot.hasError)
                                    return Text('');
                                  else
                                    return Text(
                                      snapshot.data!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                              }
                            },
                          ),
                          Text(
                            '  -  ' + Utils.formatProcessTime(notificationDate!),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
