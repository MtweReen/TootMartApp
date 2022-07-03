// import 'dart:async';
//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CasheHelper {
// //   static late SharedPreferences sharedPreferences;
// //
// //   static init() async {
// //     sharedPreferences = await SharedPreferences.getInstance();
// //   }
// //
// //   static Future<bool> putData({
// //     required String key,
// //     required bool boolValue,
// //   }) async {
// //     return await sharedPreferences.setBool(key, boolValue);
// //   }
// //
// //   static dynamic getData({
// //     required String key,
// //   }) {
// //     return sharedPreferences.get(key);
// //   }
// //   static Future<bool> saveData({
// //     required String key,
// //     required dynamic value,
// //   }) async {
// //
// //     if(value is String) return await sharedPreferences.setString(key, value);
// //     if(value is int) return await sharedPreferences.setInt(key, value);
// //     if(value is bool) return await sharedPreferences.setBool(key, value);
// //     return await sharedPreferences.setDouble(key, value);
// //   }
// // //   static Future<bool> saveModel({
// // //   required Data data,
// // // })async{
// // //     return await sharedPreferences.set
// // //   }
// //   static Future<bool>  removeData({
// //     required String key,
// //   })async{
// //     return await sharedPreferences.remove(key);
// //   }
// //
// //   static SaveUserLogin({required LoginModel dataloginModel})async{
// //     await  sharedPreferences.setString('name', dataloginModel.data!.name!);
// //     await  sharedPreferences.setInt('id', dataloginModel.data!.id!);
// //     await  sharedPreferences.setString('phone', dataloginModel.data!.phone!);
// //     await  sharedPreferences.setString('profile', dataloginModel.data!.profile!);
// //     await  sharedPreferences.setString('email', dataloginModel.data!.email!);
// //   }
//
//   // Future<Data> getUserLogin({required Data dataloginModel})async{
//   //  final name= await  sharedPreferences.getString('name');
//   //  final id=  await  sharedPreferences.getInt('id');
//   //  final phone= await  sharedPreferences.getString('phone');
//   //  final profile= await  sharedPreferences.getString('profile');
//   //  final email=await  sharedPreferences.getString('email');
//   //
//   //   return Data(
//   //     name:name,
//   //     id: id,
//   //     phone: phone,
//   //     profile: profile,
//   //     email: email
//   //   );
//   // }
//
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
