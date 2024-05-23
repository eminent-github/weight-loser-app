import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';

class MonthlyPlanController extends GetxController {
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;
  var userName = "".obs;

  PackagesList? monthlyPackage;
  getPaymentData(PackagesList amonthlyPackage) {
    monthlyPackage = amonthlyPackage;
  }

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTargetAndCurrentWeight();
  }

  // if (purchaseDetails.pendingCompletePurchase) {
  //     await iap.completePurchase(purchaseDetails).then((value) {
  //       if (purchaseStatus == PurchaseStatus.purchased) {
  //         isLoading.value = false;
  //         customSnackbar(
  //           title: AppTexts.success,
  //           message: "Payment Successful!",
  //           icon: const Icon(
  //             Icons.check_circle,
  //             color: Colors.green,
  //           ),
  //         );
  //         paymentPostApi(
  //           PostPaymentModel(
  //               packageId: monthlyPackage!.id!,
  //               amount: monthlyPackage!.discountPrice ?? 0,
  //               discount: monthlyPackage!.discountPercent ?? 0,
  //               discountPrice: monthlyPackage!.discountPrice ?? 0,
  //               totalAmount: monthlyPackage!.price!,
  //               status: "paid",
  //               duration: monthlyPackage!.duration ?? 0),
  //           "Apple",
  //         );
  //       }
  //     });
  //   }

  DateTime expectedDate(
      {required num targetWeight,
      required num currentWeight,
      required String weightUnit}) {
    // log("cur :$currentWeight tar :$targetWeight");
    return DateTime.now().add(
      Duration(
        days: daysToLoseWeight(
          currentWeight:
              weightUnit == "kg" ? currentWeight * 2.2 : currentWeight,
          goalWeight: weightUnit == "kg" ? targetWeight * 2.2 : targetWeight,
          weightPerWeek: 1.5,
        ),
      ),
    );
  }

  getTargetAndCurrentWeight() async {
    targetWeight.value = (await StorageServivce.getTargetWeight()) ?? 0;
    currentWeight.value = (await StorageServivce.getCurrentWeight()) ?? 0;
    weightUnit.value = (await StorageServivce.getWeightUnit()) ?? "lb";
    userName.value = (await StorageServivce.getUserName()) ?? "unKnown";
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    // log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    // print("days------${((numbeOfWeeks / 4.34524) * 30).round()}");
    return ((numbeOfWeeks / 4.34524) * 30).round();
  }
}
