import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/app_colors.dart';
import '../../../../helper/utils.dart';
import '../../../common_wigets/main_button.dart';

class WorkerWidget extends StatelessWidget {
  String workerName;
  String workerDepartment;
  Function? onPressed;
  String imageUrl;

  WorkerWidget({
    required this.imageUrl,
    required this.onPressed,
    required this.workerName,
    required this.workerDepartment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                height: 233.h,
                width: 312.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 26.h),
                      child: Container(
                        height: 149.h,
                        width: 312.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainColor1.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 7), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(17.r),
                        ),

                        //child: ,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: MainButton(
                            text: 'تعيين',
                            width: 178.w,
                            height: 50.h,
                            onPressed: () {
                              onPressed!();
                            })),
                    Positioned(
                      top: 0,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainColor1.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.mainColor1,
                                width: 6,
                              ),
                            ),
                            child: Utils.buildImage(url: imageUrl, width: 100.65.w, height: 100.65.w),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            workerName,
                            style: TextStyle(
                              color: AppColors.mainColor1,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 1,
                            ),
                          ),
                          Text(
                            workerDepartment,
                            style: TextStyle(
                              color: AppColors.grayLight,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w200,
                              // letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          );
        });
  }
}
