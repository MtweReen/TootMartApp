import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/country/country.dart';
import 'core/constants/constants.dart';
import 'features/map/map_provider.dart';

class SplshScreen extends StatefulWidget {
  const SplshScreen({Key? key}) : super(key: key);

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  @override
  void initState() {
    Provider.of<MapProvider>(context, listen: false).start();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CountryScreen(fromSetting: false,)),
          (route) => false),
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
