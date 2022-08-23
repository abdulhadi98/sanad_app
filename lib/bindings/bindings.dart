import 'package:get/get.dart';
import 'package:wits_app/controller/global_controller.dart';

class GolbalBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>( GlobalController());
  }
}

// class DetailsBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<DetailsController>(() => DetailsController());
//   }
// }