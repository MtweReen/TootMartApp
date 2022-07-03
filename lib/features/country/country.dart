import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import 'componnent/body.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({ Key? key }) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarNoTitle(),
      body: const CountrySelectionBody(),
      
    );
  }
}