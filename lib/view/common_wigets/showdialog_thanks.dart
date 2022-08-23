import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/view/common_wigets/title_widget.dart';

class DialogContentThanks extends StatelessWidget {
  const DialogContentThanks({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return StatefulBuilder(
            builder: (context, setState) {
              return InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                  height: height,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: onTap,
                              child: SvgPicture.asset(
                                'assets/icons/Icon Close Light-1.svg',
                                width: 16.w,
                                height: 16.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 3,
                      ),
                      TitleWidget(
                        tilte: 'شكراً لك',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
