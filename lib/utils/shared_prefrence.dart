import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loss_app/common/app_keys.dart';

class StorageServivce {
  static Future<bool> saveToken(String token) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setString(AppKeys.userTokenKey, token);
  }

  static Future<bool> saveGender(String genderSelection) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setString(
        AppKeys.genderSelectionKey, genderSelection);
  }

  static Future<bool> saveCurrentWeight(int currentWeight) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setInt(AppKeys.currentWeight, currentWeight);
  }

  static Future<int?> getCurrentWeight() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getInt(AppKeys.currentWeight);
  }

  static Future<bool> saveWeightUnit(String currentWeight) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setString(AppKeys.weightUnit, currentWeight);
  }

  static Future<String?> getWeightUnit() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getString(AppKeys.weightUnit);
  }

  static Future<bool> saveTargetWeight(int targetWeight) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setInt(AppKeys.targetWeight, targetWeight);
  }

  static Future<int?> getTargetWeight() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getInt(AppKeys.targetWeight);
  }

  static Future<bool> saveUserName(String userName) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setString(AppKeys.userName, userName);
  }

  static Future<String?> getToken() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getString(AppKeys.userTokenKey);
  }

  static Future<String?> getGender() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getString(AppKeys.genderSelectionKey);
  }

  static Future<String?> getUserName() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getString(AppKeys.userName);
  }

  static Future<String?> getGoalDate() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.getString(AppKeys.goalDateKey);
  }

  static Future<bool> saveGoalDate(String goalDate) async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return await sharedPrefernce.setString(AppKeys.goalDateKey, goalDate);
  }

  static Future<bool> logout() async {
    var sharedPrefernce = await SharedPreferences.getInstance();
    return sharedPrefernce.remove(AppKeys.userTokenKey);
  }
}
