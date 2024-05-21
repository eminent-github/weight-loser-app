import 'package:get/get.dart';

import '../controller/challenge_controller.dart';
class ChallengeBinding implements Bindings {
  @override
  void dependencies() {
      Get.lazyPut<ChallengeController>(
      () => ChallengeController(
        
      ),
    );
  }
  
}