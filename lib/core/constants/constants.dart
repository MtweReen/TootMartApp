import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toot_mart/core/constants/colors.dart';

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

String translateString(String a,String b){
  return prefs.getString("lang")=='en'?a:b;
}


