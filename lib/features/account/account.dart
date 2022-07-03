import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/auth/presentation/widgets/guest_view.dart';
import 'package:toot_mart/features/auth/presentation/widgets/login_body.dart';


import '../../core/widgets/profile_item.dart';
import '../auth/data/business_logic/auth_state.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translateString('Account', 'الحساب'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:BlocBuilder<AuthCubit,AuthStates>(
        builder: (context,state){
          return Column(
            children: [
              if(AuthCubit.get(context).currentUserState == 0 || AuthCubit.get(context).currentUserState == null)
                GuestView(),
              if(AuthCubit.get(context).currentUserState == 1)
                LoginView(),
            ],
          );
        },
      ),
    );
  }
}
