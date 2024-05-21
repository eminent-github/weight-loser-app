import 'package:get/get.dart';

import '../controller/doctor_appointment_controller.dart';

class DoctorAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorAppointmentController>(
        () => DoctorAppointmentController());
  }
}
