// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/network/local/cache_helper.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/account/account.dart';
import 'package:toot_mart/features/onboarding/onboarding.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import '../../../../../core/helper/validation.dart';
import '../../../../business_logic/social/socialCubit.dart';
import '../../../../splash.dart';
import '../../../checkout/business_logic/check_out_cubit.dart';
import '../../../layout/layout.dart';
import '../../data/business_logic/auth_cubit.dart';
import '../../data/business_logic/auth_state.dart';
import 'check_box_with_text.dart';

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
          // MagicRouter.navigateTo(const LayoutScreen(index: 0,));
          AuthCubit.get(context).changeUserState(AccountStates.GUEST);
          CartCubit.get(context).getcart();

          HomeCubitCubit.get(context)
            ..getFavourites()
            ..getHomeItems()
            ..getRooms();
          CheckOutCubit.get(context).getAreas();
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
                const VerticalSpace(value: 3),
                Center(
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: headingStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const VerticalSpace(value: 3),
                Text(
                  LocaleKeys.email.tr(),
                  style: headingStyle.copyWith(color: colorGrey),
                ),
                const VerticalSpace(value: 1),
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
                const VerticalSpace(value: 2),
                Text(
                  LocaleKeys.password.tr(),
                  style: headingStyle.copyWith(color: colorGrey),
                ),
                const VerticalSpace(value: 1),
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
                const VerticalSpace(value: 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckBoxWithText(
                      text: LocaleKeys.remember_me.tr(),
                    ),
                    CustomTextButton(
                      onPressed: () {
                        AuthCubit.get(context)
                            .changeUserState(AccountStates.FORGET_PASSWORD);
                      },
                      text: LocaleKeys.forget_password.tr(),
                      size: SizeConfig.defaultSize! * 1.3,
                    )
                  ],
                ),
                const VerticalSpace(value: 2),
                (state is! LoginUserLoadingstate)
                    ? CustomGeneralButton(
                        text: LocaleKeys.login.tr(),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.LoginUser(userNameController.text,
                                passwordController.text);
                          }
                        })
                    : Center(
                        child: CircularProgressIndicator(color: kMainColor)),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                      AuthCubit.get(context)
                          .changeUserState(AccountStates.REGISTER);
                    }),
                const VerticalSpace(value: 3),
                BlocConsumer<SocialCubit, SocialState>(
                  listener: (context, state) {
                    if (state is GoogleAuthniticationSuccessState) {
                      SocialCubit.get(context).socialLoginApi(context);
                    } else if (state is AppleAuthniticationSuccessState) {
                      SocialCubit.get(context).socialLoginApi(context);
                    } else if (state is SocialLoginApiSuccessState) {
                      MagicRouter.navigateAndPopAll(const SplshScreen());
                      AuthCubit.get(context)
                          .changeUserState(AccountStates.GUEST);
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).googleSignUp(context);
                          },
                          child: SizedBox(
                            width: SizeConfig.screenWidth! * 0.1,
                            height: SizeConfig.screenHeight! * 0.08,
                            child: Image.asset(
                              "asset/images/google.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).signInWithApple(context);
                          },
                          child: SizedBox(
                            width: SizeConfig.screenWidth! * 0.1,
                            height: SizeConfig.screenHeight! * 0.08,
                            child: Image.asset(
                              "asset/images/apple.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
