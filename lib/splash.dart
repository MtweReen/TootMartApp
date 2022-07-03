import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/onboarding/onboarding.dart';

import 'core/constants/constants.dart';


class SplshScreen extends StatefulWidget {
  const SplshScreen({Key? key}) : super(key: key);

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: kMainColor,
        height: MediaQuery.of(context).size.height,
        child:  Center(child: Image.asset(kLogo),),
      ),
    );
  }
}
