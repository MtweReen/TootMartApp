// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toot_mart/core/constants/colors.dart';

import '../../features/auth/data/model/user_model.dart';

const kLogo = 'asset/images/logo.png';
const kHomeLayout = '/';

TextStyle headingStyle = TextStyle(
  fontFamily: 'URW DIN Arabic',
  fontSize: 16,
  color: colordeepGrey,
);

//////////////////////////////////////////////////

Widget logoImage() {
  return Center(
    child: Image.asset(kLogo),
  );
}
//////////////////////////////////////////////////

appbarNoTitle() {
  return AppBar(
    toolbarHeight: 0.0,
    elevation: 0.0,
  );
}

/////////////////////////////////////////////////

late SharedPreferences prefs;

Future startShared() async {
  prefs = await SharedPreferences.getInstance();
}

//////////////////////////////////////////////////////////

String translateString(String a, String b) {
  return prefs.getString("lang") == 'en' ? a : b;
}

////////////////////////////////////////////////////////////
customAppbar({required String title, required context, VoidCallback? press}) {
  return AppBar(
    elevation: 3,
    backgroundColor: Colors.white,
    centerTitle: false,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: headingStyle.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: MediaQuery.of(context).size.width * 0.04),
    ),
    leading: InkWell(
      onTap: press,
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
  );
}
/////////////////////////////////////////////////////////////

late BitmapDescriptor markerImage;
mapIcon() async {
  markerImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(), 'asset/images/noun-pin.png');
}

////////////////////////////////////////////////////////////

var deviceId;
UserModel? kUser;
const kBgImage = 'assets/images/splash_bg.png';
