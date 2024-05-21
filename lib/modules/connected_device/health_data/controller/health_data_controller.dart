import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/utils/watch_data_utils.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/widgets/health_data_item.dart';

class HealthDataController extends GetxController {
  var healthAppState = AppState.DATA_NOT_FETCHED.obs;
  var nofSteps = 0.obs;
  var bloodPressureSis = "0".obs;
  var bloodPressureDis = "0".obs;
  var heartRate = "0".obs;
  var sleepList = "0 hr 0 min".obs;
  var bloodOxygen = "0".obs;
  var workoutDist = "0".obs;
  var workoutCalories = "0".obs;
  final GetStorage storage = GetStorage();
  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();
  // All types available depending on platform (iOS ot Android).
  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  double convertDistanceWalkedToKMs(HealthDataUnit unit, double value,
      HealthDataPoint latestDistanceElement) {
    if (unit == HealthDataUnit.METER) {
      value = (double.tryParse(latestDistanceElement.value.toString()) ?? 0);

      value = value / 1000;
    } else if (unit == HealthDataUnit.MILE) {
      value = (double.tryParse(latestDistanceElement.value.toString()) ?? 0);
      value = value * 1.60934;
    }
    return value;
  }

  @override
  void onInit() {
    Health().configure(useHealthConnectIfAvailable: true);
    if (storage.hasData(AppKeys.offlineConnectedAuth)) {
      if (storage.read(AppKeys.offlineConnectedAuth)) {
        fetchData();
      } else {
        authorize();
      }
    } else {
      authorize();
    }

    super.onInit();
  }

  Future<void> installHealthConnect() async {
    await Health().installHealthConnect();
  }

  Future<void> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final status = await Health().getHealthConnectSdkStatus();

    contentHealthConnectStatus = Text('Health Connect Status: $status');
    healthAppState.value = AppState.HEALTH_CONNECT_STATUS;
  }

  /// Authorize, i.e. get permissions to access relevant health data.
  Future<void> authorize() async {
    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have health permissions
    bool? hasPermissions =
        await Health().hasPermissions(types, permissions: permissions);

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized = await Health()
            .requestAuthorization(types, permissions: permissions);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }
    if (authorized) {
      await storage.write(AppKeys.offlineConnectedAuth, true);
      fetchData();
    } else {
      await storage.write(AppKeys.offlineConnectedAuth, false);
      healthAppState.value = AppState.AUTH_NOT_GRANTED;
    }
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future<void> fetchData() async {
    healthAppState.value = AppState.FETCHING_DATA;

    await fetchStepData();
    await fetchBloodPressuresys();
    await fetchBloodPressureDis();
    await fetchHeartRate();
    await fetchSleep();
    await fetchBloodOxygen();
    await fetchWorkout();
    // await fetchWalkingDistance();

    // update the UI to display the results

    healthAppState.value = AppState.DATA_READY;
  }

  Future<void> fetchBloodPressuresys() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions([
          HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        ]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization([
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      ]);
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: [
            HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
          ],
          startTime: yesterday,
          endTime: now,
        );

        // Extract systolic and diastolic values
        if (list.isNotEmpty) {
          // Format blood pressure in the desired format
          bloodPressureSis.value =
              '${(list[0].value as NumericHealthValue).numericValue}';
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchBloodPressureDis() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions([
          HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        ]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization([
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      ]);
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: [
            HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
          ],
          startTime: yesterday,
          endTime: now,
        );

        // Extract systolic and diastolic values
        if (list.isNotEmpty) {
          bloodPressureDis.value =
              "${(list[0].value as NumericHealthValue).numericValue}";
          // Format blood pressure in the desired format
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchHeartRate() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions([
          HealthDataType.HEART_RATE,
        ]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization([
        HealthDataType.HEART_RATE,
      ]);
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: [
            HealthDataType.HEART_RATE,
          ],
          startTime: yesterday,
          endTime: now,
        );

        // Extract systolic and diastolic values
        if (list.isNotEmpty) {
          heartRate.value =
              "${(list[0].value as NumericHealthValue).numericValue}";
          // Format blood pressure in the desired format
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchStepData() async {
    int? steps;
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    bool stepsPermission =
        await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await Health().requestAuthorization([HealthDataType.STEPS]);
    }
    if (stepsPermission) {
      try {
        steps = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        debugPrint("Exception in getTotalStepsInInterval: $error");
      }

      nofSteps.value = (steps == null) ? 0 : steps;
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchSleep() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions(
          Platform.isAndroid
              ? [
                  HealthDataType.SLEEP_DEEP,
                ]
              : [
                  HealthDataType.SLEEP_IN_BED,
                ],
        ) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization(
        Platform.isAndroid
            ? [
                HealthDataType.SLEEP_DEEP,
              ]
            : [
                HealthDataType.SLEEP_IN_BED,
              ],
      );
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: Platform.isAndroid
              ? [
                  HealthDataType.SLEEP_DEEP,
                ]
              : [
                  HealthDataType.SLEEP_IN_BED,
                ],
          startTime: yesterday,
          endTime: now,
        );
        debugPrint("Exception in getHealthDataFromTypes: $list");
        if (list.isNotEmpty) {
          int totalSleep = 0;
          for (var element in list) {
            totalSleep += (element.value as NumericHealthValue).numericValue.toInt();
          }

          sleepList.value = totalSleep < 60
              ? "0 hr $totalSleep min"
              : "${totalSleep ~/ 60} hr ${totalSleep % 60} min";

          //  HealthDataPoint vvvvv= list.reduce((value, element) => (value as NumericHealthValue).numericValue+(element as NumericHealthValue).numericValue);
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchBloodOxygen() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions([
          HealthDataType.BLOOD_OXYGEN,
        ]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization([
        HealthDataType.BLOOD_OXYGEN,
      ]);
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: [
            HealthDataType.BLOOD_OXYGEN,
          ],
          startTime: yesterday,
          endTime: now,
        );

        // Extract systolic and diastolic values
        if (list.isNotEmpty) {
          print(list.first);
          bloodOxygen.value =
              "${(list[0].value as NumericHealthValue).numericValue * 100}";
          // Format blood pressure in the desired format
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  Future<void> fetchWorkout() async {
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    bool stepsPermission = await Health().hasPermissions([
          HealthDataType.WORKOUT,
        ]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await Health().requestAuthorization([
        HealthDataType.WORKOUT,
      ]);
    }
    if (stepsPermission) {
      try {
        // fetch health data
        var list = await Health().getHealthDataFromTypes(
          types: [
            HealthDataType.WORKOUT,
          ],
          startTime: yesterday,
          endTime: now,
        );

        // Extract systolic and diastolic values
        if (list.isNotEmpty) {
          int allDistance = 0;
          int allCalories = 0;

          for (var element in list) {
            allDistance = allDistance +
                (element.value as WorkoutHealthValue).totalDistance! ~/ 1000;
            allCalories = allCalories +
                (element.value as WorkoutHealthValue).totalEnergyBurned!;
          }
          workoutDist.value = allDistance.toString();
          workoutCalories.value = allCalories.toString();

          // Format blood pressure in the desired format
        }
      } catch (error) {
        debugPrint("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      debugPrint("Authorization not granted - error in authorization");
      healthAppState.value = AppState.DATA_NOT_FETCHED;
    }
  }

  // Future<void> fetchWalkingDistance() async {
  //   // get data within the last 24 hours
  //   final now = DateTime.now();
  //   final yesterday = now.subtract(const Duration(hours: 24));
  //   // Clear old data points
  //   bool stepsPermission = await Health().hasPermissions([
  //         HealthDataType.DISTANCE_WALKING_RUNNING,
  //       ]) ??
  //       false;
  //   if (!stepsPermission) {
  //     stepsPermission = await Health().requestAuthorization([
  //       HealthDataType.DISTANCE_WALKING_RUNNING,
  //     ]);
  //   }
  //   if (stepsPermission) {
  //     try {
  //       // fetch health data
  //       var list = await Health().getHealthDataFromTypes(
  //         types: [
  //           HealthDataType.DISTANCE_WALKING_RUNNING,
  //         ],
  //         startTime: yesterday,
  //         endTime: now,
  //       );
  //       // Extract systolic and diastolic values
  //       if (list.isNotEmpty) {
  //         print("walking------${list.first}");
  //         int allDistance = 0;
  //         for (var element in list) {
  //           allDistance = allDistance +
  //               (element.value as NumericHealthValue).numericValue ~/ 1000;
  //         }
  //         runningDist.value = allDistance.toString();
  //         // Format blood pressure in the desired format
  //       }
  //     } catch (error) {
  //       debugPrint("Exception in getHealthDataFromTypes: $error");
  //     }
  //   } else {
  //     debugPrint("Authorization not granted - error in authorization");
  //     healthAppState.value = AppState.DATA_NOT_FETCHED;
  //   }
  // }

  // Future<void> revokeAccess() async {
  //   try {
  //     await Health().revokePermissions();
  //   } catch (error) {
  //     debugPrint("Exception in revokeAccess: $error");
  //   }
  // }

  Widget get _contentFetchingData => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(
                strokeWidth: 10,
              )),
          const Text('Fetching data...')
        ],
      );

  Widget get _contentDataReady => ListView(
        children: [
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.local_fire_department_rounded,
              color: Color(0xffff5107),
            ),
            title: "Steps",
            unit: "steps",
            value: nofSteps.value.toString(),
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: "Blood Pressure",
            unit: "mmHg",
            value: "$bloodPressureSis/$bloodPressureDis",
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: "Heart Rate",
            unit: "BPM",
            value: heartRate.value,
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.air,
              color: Colors.green,
            ),
            title: "Blood Oxygen",
            unit: "%",
            value: bloodOxygen.value,
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.local_fire_department_rounded,
              color: Color(0xffff5107),
            ),
            title: "Workout Distance",
            unit: "km",
            value: workoutDist.value,
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.local_fire_department_rounded,
              color: Color(0xffff5107),
            ),
            title: "Workout Calories",
            unit: "kcal",
            value: workoutCalories.value,
          ),
          HealthDataItem(
            time: DateTime.now(),
            myIcon: const Icon(
              Icons.bed,
              color: Colors.lightBlue,
            ),
            title: "Sleep",
            unit: "",
            value: sleepList.value,
          ),
        ],
      );

  final Widget _contentNoData = const Text('No Data to show');

  final Widget _contentNotFetched =
      const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("Press 'Auth' to get permissions to access health data."),
    Text("Press 'Fetch Data' to get health data."),
  ]);

  final Widget _authorized = const Text('Authorization granted!');

  final Widget _authorizationNotGranted = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Authorization not given.'),
      Text(
          'For Google Fit please check your OAUTH2 client ID is correct in Google Developer Console.'),
      Text(
          'For Google Health Connect please check if you have added the right permissions and services to the manifest file.'),
      Text('For Apple Health check your permissions in Apple Health.'),
    ],
  );

  Widget contentHealthConnectStatus = const Text(
      'No status, click getHealthConnectSdkStatus to get the status.');

  Widget get stepsFetched => Text('Total number of steps: ${nofSteps.value}.');

  Widget get content => switch (healthAppState.value) {
        AppState.DATA_READY => _contentDataReady,
        AppState.DATA_NOT_FETCHED => _contentNotFetched,
        AppState.FETCHING_DATA => _contentFetchingData,
        AppState.NO_DATA => _contentNoData,
        AppState.AUTHORIZED => _authorized,
        AppState.AUTH_NOT_GRANTED => _authorizationNotGranted,
        AppState.HEALTH_CONNECT_STATUS => contentHealthConnectStatus,
      };
}
