import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/country/country.dart';
import 'business_logic/home/home_cubit_cubit.dart';
import 'core/constants/constants.dart';
import 'features/auth/data/business_logic/auth_cubit.dart';
import 'features/layout/layout.dart';
import 'features/onboarding/onboarding.dart';

class SplshScreen extends StatefulWidget {
  const SplshScreen({Key? key}) : super(key: key);

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  Widget screen = const CountryScreen(
    fromSetting: false,
  );

  getScreen() {
      HomeCubitCubit.get(context)
      ..getHomeItems()
      ..getRooms();
    CheckOutCubit.get(context).getAreas();
    CategoryCubit.get(context).getCategory(page: 1);
    if (prefs.getBool("is_login") == true) {
      AuthCubit.get(context).getUser();
      CartCubit.get(context).getcart();
       HomeCubitCubit.get(context).getFavourites();
    }
    if (prefs.getBool("selection") == true) {
      if (prefs.getBool("is_onboearding") == true) {
        setState(() {
          screen = const LayoutScreen();
        });
      } else {
        setState(() {
          screen = const OnBoardingScreen();
        });
      }
    } else {
      setState(() {
        screen = const CountryScreen(
          fromSetting: false,
        );
      });
    }
  }

  @override
  void initState() {
    getScreen();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => screen), (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: kMainColor,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              kLogo,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
