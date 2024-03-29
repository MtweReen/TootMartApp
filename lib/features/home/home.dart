import 'package:flutter/material.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../business_logic/home/home_cubit_cubit.dart';
import '../../core/constants/constants.dart';
import 'componnent/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

@override
  void initState() {
    HomeCubitCubit.get(context).getHomeItems();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: LocaleKeys.home.tr(),inLayout:true ),
      body: const HomeBody(),
     
    );
  }
}