import 'package:get/get.dart';

import '../controller/challenge_space_controller.dart';


class ChallengeSpaceBinding implements Bindings
 {
  @override
  void dependencies() {
     Get.lazyPut<ChallengeSpaceController>(
      () => ChallengeSpaceController(
        
      ),
    );
  }
  
}