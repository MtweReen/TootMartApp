import 'package:flutter/material.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/constants.dart';

import 'componnent/body.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    HomeCubitCubit.get(context).getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: translateString("favourite", "المفضلة"),
          context: context,
          inLayout: true),
      body: RefreshIndicator(
          onRefresh: () async => HomeCubitCubit.get(context).getFavourites(),
          child: const FavouriteBody()),
    );
  }
}
