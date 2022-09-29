import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wits_app/helper/app_colors.dart';
import 'package:wits_app/model/return_details_model.dart';
import 'package:wits_app/network/urls_container.dart';
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

class DialogContentImages extends StatelessWidget {
  DialogContentImages({Key? key, required this.onTap, this.gridHeight}) : super(key: key);
  final Function() onTap;
  double? gridHeight;
  List<ImageModel>? imagesList;

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
                  child: SingleChildScrollView(
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
                        Column(
                          children: [
                            SizedBox(
                              width: 295.w,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ':صور السائقين',
                                  style: TextStyle(color: AppColors.textColorXDarkBlue, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: 305.w,
                              height: gridHeight,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  border: Border.all(
                                    color: AppColors.mainColor2,
                                  )),
                              padding: EdgeInsets.all(25.r),
                              alignment: Alignment.topCenter,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 105.w, childAspectRatio: 1.05, crossAxisSpacing: 35.w, mainAxisSpacing: 20.h),
                                  itemCount: imagesList!.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      height: 91.h,
                                      width: 106.w,
                                      color: Colors.amber,
                                      child: Image.network(
                                        UrlsContainer.imagesUrl + '/' + imagesList![index].path!,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
