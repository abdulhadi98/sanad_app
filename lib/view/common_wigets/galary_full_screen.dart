// import 'dart:ui';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:wave_flutter/helper/app_colors.dart';
// import 'package:wave_flutter/helper/utils.dart';
// import 'package:wave_flutter/local/app_local.dart';
// import 'package:wave_flutter/models/image_model.dart';
// import 'package:wave_flutter/ui/common_widgets/base_statefull_widget.dart';
// import 'package:wits_app/helper/app_colors.dart';

// class GalleryFullScreen extends BaseStateFullWidget {
//   final List<String> imageUrls;
//   final initialIndex;

//   GalleryFullScreen(this.imageUrls, {this.initialIndex = 0});

//   @override
//   _GalleryFullScreenState createState() => _GalleryFullScreenState();
// }

// class _GalleryFullScreenState
//     extends BaseStateFullWidgetState<GalleryFullScreen> {
//   final _currentItemController = BehaviorSubject<int>();
//   CarouselController _carouselController = CarouselController();

//   @override
//   void initState() {
//     super.initState();
//     widget.imageUrls.forEach((e) => print('0000000000000 $e'));
//     _currentItemController.sink.add(widget.initialIndex);
//   }

 
// }



// class GalleryFullScreen1 extends StatefulWidget {
//   const GalleryFullScreen1({Key? key}) : super(key: key);

//   @override
//   State<GalleryFullScreen1> createState() => _GalleryFullScreen1State();
// }

// class _GalleryFullScreen1State extends State<GalleryFullScreen1> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           right: 0,
//           bottom: 0,
//           left: 0,
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//             child: Container(
//               color: AppColors.mainColor.withOpacity(.1),
//               alignment: Alignment.center,
//             ),
//           ),
//         ),
//         CarouselSlider(
//           carouselController: _carouselController,
//           options: CarouselOptions(
//             height: height,
//             // aspectRatio: 16/9,
//             viewportFraction: 1.0,
//             initialPage: widget.initialIndex,
//             enableInfiniteScroll: false,
//             reverse: false,
//             enlargeCenterPage: true,
//             scrollDirection: Axis.horizontal,
//             onPageChanged: (index, reason) {
//               _currentItemController.sink.add(index);
//             },
//           ),
//           items: widget.imageUrls
//               .map((item) => buildImageItem(item))
//               .toList()
//               .cast<Widget>(),
//         ),
//         if (widget.imageUrls.length > 1)
//           Positioned(
//             bottom: height * .025,
//             left: 0,
//             right: 0,
//             child: StreamBuilder<int>(
//                 stream: _currentItemController.stream,
//                 builder: (context, currentSnapshot) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: widget.imageUrls.map((url) {
//                       int index = widget.imageUrls.indexOf(url);
//                       return Container(
//                         width: 7.5,
//                         height: 7.5,
//                         margin: EdgeInsets.symmetric(horizontal: 2.5),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: currentSnapshot.data == index
//                               ? Colors.white
//                               : Colors.white38,
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 }),
//           ),
//         Container(
//           alignment: Alignment.bottomCenter,
//           margin: EdgeInsets.only(
//             bottom: height * .05,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   _carouselController.previousPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.linear);
//                 },
//                 child: Icon(
//                   Icons.arrow_back_ios_rounded,
//                   color: AppColors.black,
//                   size: width * .15,
//                 ),
//               ),
//               SizedBox(
//                 width: width * .15,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _carouselController.nextPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.linear);
//                 },
//                 child: Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: AppColors.black,
//                   size: width * .15,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildImageItem(String url) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(width * .035),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//                 child: Utils.buildImage(
//                     url: url,
//                     width: double.infinity,
//                     height: height / 1.2,
//                     fit: BoxFit.contain),
//               ),
//             ),
//             Positioned(
//               right: width * .06,
//               // top: 0,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.white, width: .5),
//                     shape: BoxShape.circle,
//                     color: AppColors.mainColor1,
//                   ),
//                   child: Icon(
//                     Icons.close,
//                     color: AppColors.gray,
//                     size: width * .050,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
