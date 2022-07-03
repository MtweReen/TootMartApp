import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../utiles/size_config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Stack(
        children: <Widget>[
          Positioned(
              top: SizeConfig.defaultSize! * 3.7,
              right: 10,
              left: 10,
              child: SizedBox(
                height: SizeConfig.defaultSize! * 7,
                child: Image.asset(
                  kLogo,
                  color: kMainColor,
                ),
              )),
          SizedBox(
            height: SizeConfig.defaultSize! * 11,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: kMainColor,
                      size: SizeConfig.defaultSize! * 3.5,
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          // AppCubit.get(context).getCart();
                          // MagicRouter.navigateTo(const ShoppingCartView());
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: kMainColor,
                          size: SizeConfig.defaultSize! * 3.5,
                        ),
                      ),
                      // if (AppCubit.get(context)
                      //     .cartModel!
                      //     .data!
                      //     .variations!
                      //     .isNotEmpty)
                        Positioned(
                            top: 3.0,
                            right: 4.0,
                            child: Center(
                              child: Text(
                               'dcfvgbhnjmk',
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                     // MagicRouter.navigateTo(SearchView());
                    },
                    icon: Icon(
                      Icons.search,
                      color: kMainColor,
                      size: SizeConfig.defaultSize! * 3.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
