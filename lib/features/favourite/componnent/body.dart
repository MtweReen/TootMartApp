import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/favourite/componnent/products_list.dart';
import '../../../core/utiles/size_config.dart';


class FavouriteBody extends StatefulWidget {
  const FavouriteBody({Key? key}) : super(key: key);

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.03,
          vertical: SizeConfig.screenHeight! * 0.03),
      child: (prefs.getBool("is_login") == true)
          ? FavouriteProductList(
              fromfav: true,
            )
          : Padding(
            padding:  EdgeInsets.only(top: SizeConfig.screenHeight! * 0.3),
            child: Center(
                child: Text(
                  translateString(
                      "you must login first", "يجب تسجيل الدخول اولا "),
                  style: headingStyle.copyWith(
                    color: kMainColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
          ),
    );
  }
}
