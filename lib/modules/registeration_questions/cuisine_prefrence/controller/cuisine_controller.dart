import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';

class CuisineController extends GetxController {
  late GetQuestionWithAnswerModel getQuestionWithAnswerModel;
  void toggleSelection(int index) {
    getQuestionWithAnswerModel.response!.option![index].isSelected =
        !getQuestionWithAnswerModel.response!.option![index].isSelected;
    update();
  }

  @override
  void onInit() {
    getQuestionWithAnswerModel = Get.arguments as GetQuestionWithAnswerModel;
    super.onInit();
  }
}
