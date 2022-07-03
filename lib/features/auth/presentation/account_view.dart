import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';

import '../../../core/widgets/custom_container.dart';
import '../data/business_logic/auth_cubit.dart';
import '../data/business_logic/auth_state.dart';
import 'widgets/login_body.dart';
import 'widgets/user_account.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        return kUser == null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: CustomContainer(child: LoginBody()))
            : const UserAccount();
      },
    );
  }
}
