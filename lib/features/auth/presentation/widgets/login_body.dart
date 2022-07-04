import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/network/local/cache_helper.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/account/account.dart';
import 'package:toot_mart/features/auth/presentation/widgets/register_body.dart';

import 'package:toot_mart/translations/locale_keys.g.dart';
import '../../../../../core/helper/validation.dart';
import '../../data/business_logic/auth_cubit.dart';
import '../../data/business_logic/auth_state.dart';
import 'check_box_with_text.dart';
import 'forget_password_body.dart';

class LoginView extends StatelessWidget {
  LoginView({
    Key? key,
  }) : super(key: key);

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginUserLoaded) {
          CasheHelper.SaveUser(user: AuthCubit.get(context).user!);
          kUser = AuthCubit.get(context).user;
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(value: 3),
                Center(
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: headingStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                VerticalSpace(value: 3),
                Text(
                  LocaleKeys.email.tr(),
                  style: headingStyle.copyWith(color: colorGrey),
                ),
                VerticalSpace(value: 1),
                CustomTextFormField(
                  focusNode: emailFocusNode,
                  controller: userNameController,
                  inputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    return validateEmail(userNameController.text);
                  },
                  onEditingComplete: () {
                    emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                ),
                VerticalSpace(value: 2),
                Text(
                  LocaleKeys.password.tr(),
                  style: headingStyle.copyWith(color: colorGrey),
                ),
                VerticalSpace(value: 1),
                CustomTextFormField(
                  focusNode: passwordFocusNode,
                  isPassword: true,
                  controller: passwordController,
                  validator: (String? value) {
                    return validatePassword(value!);
                  },
                  onEditingComplete: () {
                    passwordFocusNode.unfocus();
                  },
                ),
                VerticalSpace(value: 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckBoxWithText(
                      text: LocaleKeys.remember_me.tr(),
                    ),
                    CustomTextButton(
                      onPressed: () {
                        AuthCubit.get(context).changeUserState(AccountStates.FORGET_PASSWORD);
                      },
                      text: LocaleKeys.forget_password.tr(),
                      size: SizeConfig.defaultSize! * 1.3,
                    )
                  ],
                ),
                VerticalSpace(value: 2),
                (state is! LoginUserLoadingstate)
                    ? CustomGeneralButton(
                        text: LocaleKeys.login.tr(),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.LoginUser(userNameController.text,
                                passwordController.text);
                          }
                        })
                    : CircularProgressIndicator(color: kMainColor),
                const VerticalSpace(value: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: colorGrey,
                      height: 1,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or'),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: colorGrey,
                      height: 1,
                    )),
                  ],
                ),
                const VerticalSpace(value: 2),
                CustomStrockButton(
                    text: LocaleKeys.sign_up.tr(),
                    onTap: () {
                      AuthCubit.get(context).changeUserState(AccountStates.REGISTER);
                    }),
                const VerticalSpace(value: 5),
                Center(
                  child: SizedBox(
                      height: SizeConfig.defaultSize! * 2,
                      child: Image.asset(
                        'asset/images/social.png',
                        color: kMainColor,
                      )),
                ),
                const VerticalSpace(value: 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
