import 'package:toot_mart/core/widgets/custom_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/helper/extentions.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_container.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import 'package:toot_mart/translations/locale_keys.g.dart';

import 'account_details.dart';
import 'account_item.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Header(text: LocaleKeys.account.tr(), withBackBtn: false),
              const VerticalSpace(value: 1),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                ),
                width: SizeConfig.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: SizeConfig.defaultSize! * 4,
                    ),
                    const VerticalSpace(value: 1),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.hello.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const HorizontalSpace(value: 1),
                        Text(kUser!.data!.user!.name??'')
                      ],
                    ).alignAtCenter()
                  ],
                ),
              ),
              const VerticalSpace(value: 3),
              Column(
                children: [
                  AccountItem(
                    icon: Icons.favorite_border,
                    text:  LocaleKeys.wish_list.tr(),
                    onTap: () {
                      // AuthCubit.get(context).getFavouteProducts();
                      // MagicRouter.navigateTo(const AccountWishList());
                    },
                  ),
                  AccountItem(
                    icon: Icons.person,
                    text:  LocaleKeys.account_details.tr(),
                    onTap: () {
                      MagicRouter.navigateTo(AccountDetails());
                    },
                  ),
                  AccountItem(
                    icon: Icons.sync_problem,
                    text:  LocaleKeys.order_and_exchange_policy.tr(),
                    onTap: () {
                      // MagicRouter.navigateTo(const OrderAndExchangePolicy());
                    },
                  ),
                  // AccountItem(
                  //   icon: Icons.refresh,
                  //   text:  LocaleKeys.close_account.tr(),
                  //   onTap: () {
                  //     MagicRouter.navigateTo(CloseAccount());
                  //   },
                  // ),
                  AccountItem(
                    icon: Icons.sync,
                    text:  LocaleKeys.replacement_requiests.tr(),
                    onTap: () {
                      // AuthCubit.get(context).getRefundOrders();
                      // MagicRouter.navigateTo(const ReplacementRequiests());
                    },
                  ),
                  AccountItem(
                    icon: Icons.exit_to_app,
                    text:  LocaleKeys.sign_out.tr(),
                    onTap: () {
                      // AuthCubit.get(context).SignOut();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
