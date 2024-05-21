import 'package:get/get.dart';

import '../controller/create_challenge_controller.dart';


class CreateChallengeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateChallengeController>(
      () => CreateChallengeController(
        
      ),
    );
  }
  
}