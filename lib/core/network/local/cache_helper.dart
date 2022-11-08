// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';

class CasheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool boolValue,
  }) async {
    return await sharedPreferences.setBool(key, boolValue);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  // static SaveUser({required UserModel user}) async {
  //   print('User Saved ');
  //   return await sharedPreferences.setString('User', userModelToJson(user));
  // }
  static setToken({required String token}) async {
    print('User token Saved ');
    return await sharedPreferences.setString('token', token);
  }

  static getToken() async {
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      print('No Data Saved');
    } else {
      print('token Passed');
      kToken = token;
      print(token);
      // AuthCubit.get(context).getUser();
    }
    return 'token';
  }
}
