// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/auth/presentation/widgets/forget_password_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/guest_view.dart';
import 'package:toot_mart/features/auth/presentation/widgets/login_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/register_body.dart';
import 'package:toot_mart/features/auth/presentation/widgets/reset_password_body.dart';
import '../../core/constants/constants.dart';
import '../auth/data/business_logic/auth_state.dart';
import '../profile_detail/componnent/form.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

enum AccountStates {
  GUEST,
  LOGIN,
  REGISTER,
  FORGET_PASSWORD,
  RESET_PASSWORD,
  ORDERS_VIEW,
  ACCOUNT_DETAILS
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: customAppbar(
              inLayout: kInside == 0 ? true : false,
              context: context,
              title: translateString("My Account", "حسابي"),
              press: () {
                kInside--;
                AuthCubit.get(context).changeUserState(AccountStates.GUEST);
              }),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (AuthCubit.get(context).currentUserState ==
                        AccountStates.GUEST ||
                    AuthCubit.get(context).currentUserState == null)
                  const GuestView(),
                if (AuthCubit.get(context).currentUserState ==
                    AccountStates.LOGIN)
                  LoginView(),
                if (AuthCubit.get(context).currentUserState ==
                    AccountStates.REGISTER)
                  const RegisterView(),
                if (AuthCubit.get(context).currentUserState ==
                    AccountStates.FORGET_PASSWORD)
                  ForgetPasswordView(),
                if (AuthCubit.get(context).currentUserState ==
                    AccountStates.RESET_PASSWORD)
                  ResetPasswordBody(),
                // if(AuthCubit.get(context).currentUserState == AccountStates.ORDERS_VIEW)
                //   const OrdersView(),
                if (AuthCubit.get(context).currentUserState ==
                    AccountStates.ACCOUNT_DETAILS)
                  const EditProfileForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}
