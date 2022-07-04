import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import 'componnent/body.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({ Key? key }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: translateString("favourite", "المفضلة"), context: context),
      body: const FavouriteBody(),
      
    );
  }
}