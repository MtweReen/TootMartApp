// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/services.dart';
//
// import '../../constants/constants.dart';
//
// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//
// Future<void> initPlatformState() async {
//   try {
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       deviceId = androidInfo.androidId;
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       deviceId = iosInfo.identifierForVendor;
//     }
//   } on PlatformException {
//     deviceId = <String, dynamic>{'Error:': 'Failed to get platform version.'};
//   }
// }
