import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/modules/authentication/login/binding/login_binding.dart';
import 'package:weight_loss_app/modules/authentication/login/view/login_page.dart';
import 'package:weight_loss_app/modules/dashbored/binding/dashboared_binding.dart';
import 'package:weight_loss_app/modules/dashbored/dashboared_page/dashboared_page.dart';
import 'package:weight_loss_app/modules/splash/model/question_history_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';

import '../../../widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ApiService apiService = ApiService();
  // late StreamSubscription<ConnectivityResult> subscription;
  late StreamSubscription subscription;
  final GetStorage storage = GetStorage();
  bool hasInternet = true;

  void checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    hasInternet = (connectivityResult != ConnectivityResult.none);
    setState(() {});
  }

  // void listenToConnectivityChanges() {
  //   subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) {
  //     hasInternet = (result != ConnectivityResult.none);
  //     setState(() {});
  //   });
  // }

  ///
  /* -------------------------------------------------------------------------- */
  /*                      update connectivity_plus: ^6.0.3                      */
  /* -------------------------------------------------------------------------- */
  ///
  void listenToConnectivityChanges() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        hasInternet = (result != ConnectivityResult.none);
      }
    });
  }

  ///
  ///

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    listenToConnectivityChanges();
    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        checkTokenAndNavigate();
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: AppLogo(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppAssets.splashImgUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkTokenAndNavigate() async {
    String? savedToken = await StorageServivce.getToken();

    if (savedToken != null) {
      try {
        QuestionHistoryModel questionHistoryModel = hasInternet
            ? await getQuestionHistoryApi(savedToken)
            : getOfflineQuestionHistoryApi();
        if (questionHistoryModel.isCompleted! &&
            questionHistoryModel.packageValid!) {
          Get.off(
              () => ShowCaseWidget(builder: Builder(
                    builder: (context) {
                      return const DashboaredPage();
                    },
                  )),
              binding: DashboaredBinding());
        } else {
          Get.off(() => const LoginPage(), binding: LoginBinding());
        }
      } catch (e) {
        print("int $e");
        Get.off(() => const LoginPage(), binding: LoginBinding());
      }
    } else {
      Get.off(() => const LoginPage(), binding: LoginBinding());
    }
  }

  QuestionHistoryModel getOfflineQuestionHistoryApi() {
    var historyModel = storage.read(
      AppKeys.offlineSplashPage,
    );
    return QuestionHistoryModel.fromJson(historyModel);
  }

  Future<QuestionHistoryModel> getQuestionHistoryApi(String token) async {
    var response = await apiService.get(
      ApiUrls.getPreviousQusEndPoint,
      authToken: token,
    );
    log("status code ${response.statusCode} body:${response.body}");
    if (response.statusCode == 200) {
      var dataObj = jsonDecode(response.body);
      await storage.write(AppKeys.offlineSplashPage, dataObj);
      return QuestionHistoryModel.fromJson(dataObj);
    } else {
      throw ClientException("api response failed");
    }
  }
}
