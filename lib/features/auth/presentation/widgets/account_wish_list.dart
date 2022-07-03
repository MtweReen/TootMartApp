import 'package:toot_mart/core/widgets/custom_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_app_bar.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../business_logic/app_cubit/app_cubit.dart';
import '../../data/business_logic/auth_cubit.dart';
import '../../data/business_logic/auth_state.dart';
import 'wish_list_item.dart';

class AccountWishList extends StatelessWidget {
  const AccountWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          if (state is! FavouteProductsLoadingState &&
              AuthCubit.get(context).favouritesModel != null) {
            return Column(
              children: [
                const CustomAppBar(),
                const VerticalSpace(value: 2),
                // Header(text: LocaleKeys.wish_list.tr(), withBackBtn: true),
                if (AuthCubit.get(context).favouritesModel!.data!.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                             // AppCubit.get(context).getProduct(AuthCubit.get(context).favouritesModel!.data![index].id!);
                            //  MagicRouter.navigateTo(const ProductView());
                            },
                            child: WishListItem(
                                favouritesModel:
                                    AuthCubit.get(context).favouritesModel!,
                                index: index)),
                        separatorBuilder: (context, index) => const Divider(
                              thickness: 2,
                            ),
                        itemCount: AuthCubit.get(context)
                            .favouritesModel!
                            .data!
                            .length),
                  ),
                if (AuthCubit.get(context).favouritesModel!.data!.isEmpty)
                  Expanded(
                      child: Center(
                        child: Text(
                    'LocaleKeys.your_favourite_is_empty.tr()',
                    style: TextStyle(
                          color: kMainColor,
                          fontSize: SizeConfig.defaultSize! * 2),
                  ),
                      )),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: kMainColor),
            );
          }
        },
      ),
    );
  }
}
