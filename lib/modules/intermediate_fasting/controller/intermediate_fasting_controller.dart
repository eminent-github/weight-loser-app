import 'package:get/get.dart';
import 'package:weight_loss_app/modules/intermediate_fasting/model/fasting_model.dart';
import 'package:weight_loss_app/modules/intermediate_fasting/widgets/custom_fasting_progress/custom_fasting_timer.dart';

class IntermediateFastingController extends GetxController {
  final CountDownController countDownController = CountDownController();
  var isPlaying = true.obs;

  void togglePlayPause() {
    if (!countDownController.isPaused) {
      countDownController.pause();
      isPlaying.value = false;
    } else {
      countDownController.resume();
      isPlaying.value = true;
    }
  }

  List<FastingModel> fastingList = [
    FastingModel(date: "5 June, 2023", hours: "12", status: "Normal"),
    FastingModel(date: "3 June, 2023", hours: "9", status: "Bad"),
    FastingModel(date: "5 June, 2023", hours: "12", status: "Medium"),
  ];
}
