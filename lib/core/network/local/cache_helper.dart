// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';

import '../../../features/auth/data/model/user_model.dart';
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
    String? token= sharedPreferences.getString('token');
    if(token == null){
      print('No Data Saved');
    }else{
      print('token Passed');
      kToken = token;
     // AuthCubit.get(context).getUser();
    }
    return 'token';
  }

  static getUser() async {
    String? json= sharedPreferences.getString('User');
    if(json == null){
      print('No Data Saved');
    }else{
      Map<String,dynamic> map=jsonDecode(json);
      kUser = UserModel.fromJson(map);
      print('Data Passed');
    }


    return 'user';
  }

  // static SaveUserLogin({required User userData}) async {
  //   await sharedPreferences.setString('name', userData.data!.user!.name!);
  //   await sharedPreferences.setInt('id', userData.data!.user!.id!);
  //   await sharedPreferences.setString('image', userData.data!.user!.image!);
  //   await sharedPreferences.setString('email', userData.data!.user!.email!);
  //   await sharedPreferences.setString('token', userData.data!.token!);
  // }
  //
  // Future<Data> getUserLogin({required Data dataloginModel}) async {
  //   final name = await sharedPreferences.getString('name');
  //   final id = await sharedPreferences.getInt('id');
  //   final token = await sharedPreferences.getString('token');
  //   final image = await sharedPreferences.getString('image');
  //   final email = await sharedPreferences.getString('email');
  //
  //   return Data();
  // }

}
//
//   static Future<void> inits() async => await GetStorage.init();
//   static final GetStorage _box = GetStorage();
//   static LoginModel? get getUserInfo {
//     LoginModel? profileModel;
//     if (_box.hasData('data')) {
//       profileModel = LoginModel.fromMap(_box.read('data'));
//     }
//     return profileModel;
//   }
//   static Future<void> saveBool({
//     required String key,
//     required bool value
//   }) async{
//     return await _box.write(key, value);
//   }
//
//
//   static bool get isLogged => getUserInfo != null;
//   //static bool get rememberMe =>  ;
//
//   static Future<void> cacheUserInfo(LoginModel userModel) =>
//       _box.write('data', userModel.toMap());
//
//
//   static int? get getUserId => getUserInfo?.data!.id;
//
//   static String? get getToken => getUserInfo?.token;
//
//   static User? get getUserData => getUserInfo?.data;
//
//
//   static Future<void>  removeData({
//     required String key,
//   }) async{
//     return await _box.remove('data');
//   }
// }
//
//
