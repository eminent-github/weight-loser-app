 import 'package:get/get.dart';
import '../controller/newrecipe_controller.dart';

 class NewRecipeBinding extends Bindings {
   @override
   void dependencies() {
     Get.lazyPut(() => NewRecipeController());
   }
 }