import 'package:get/get.dart';

import '../controller/fav_rasturants_controller.dart';

class FavRestaurantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavRestaurantsController());
  }
}