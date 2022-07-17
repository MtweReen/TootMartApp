import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/auth/presentation/widgets/forget_password_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/guest_view.dart';
import 'package:toot_mart/features/auth/presentation/widgets/login_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/register_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/reset_password_body.dart';
import 'package:toot_mart/features/orders/presentation/orders_view.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';


import '../../core/constants/constants.dart';
import '../auth/data/business_logic/auth_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}
// ignore: constant_identifier_names
enum AccountStates { GUEST, LOGIN, REGISTER,FORGET_PASSWORD,RESET_PASSWORD,ORDERS_VIEW}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppbar(context: context,title: LocaleKeys.account.tr(),press: (){
        AuthCubit.get(context).changeUserState(AccountStates.GUEST);
      }),
      body:BlocBuilder<AuthCubit,AuthStates>(
        builder: (context,state){
          return SingleChildScrollView(
            child: Column(
              children: [
                if(AuthCubit.get(context).currentUserState == AccountStates.GUEST ||AuthCubit.get(context).currentUserState ==null)
                  const GuestView(),
                if(AuthCubit.get(context).currentUserState == AccountStates.LOGIN)
                  LoginView(),
                if(AuthCubit.get(context).currentUserState == AccountStates.REGISTER)
                  RegisterView(),
                if(AuthCubit.get(context).currentUserState == AccountStates.FORGET_PASSWORD)
                  ForgetPasswordView(),
                if(AuthCubit.get(context).currentUserState == AccountStates.RESET_PASSWORD)
                  ResetPasswordBody(),
                if(AuthCubit.get(context).currentUserState == AccountStates.ORDERS_VIEW)
                  OrdersView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
