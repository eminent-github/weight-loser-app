import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/drag_cuisine/controller/drag_cuisine_controller.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';

class DragCuisineBinding implements Bindings {
  final List<Option> cuisineDragList;
  DragCuisineBinding({required this.cuisineDragList});
  @override
  void dependencies() {
    Get.lazyPut<DragCuisineController>(
        () => DragCuisineController()..getDragList(cuisineDragList));
  }
}
