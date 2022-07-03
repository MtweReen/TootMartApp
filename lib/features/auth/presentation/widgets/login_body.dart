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
                children: [
                  VerticalSpace(value: 3),
                  Text(
                    LocaleKeys.login.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
                  CustomTextFormField(
                    label: LocaleKeys.email.tr(),
                    controller: userNameController,
                    inputType: TextInputType.emailAddress,
                    validator: (String? value) {
                      return validateEmail(userNameController.text);
                    },
                  ),
                  VerticalSpace(value: SizeConfig.defaultSize! * 0.3),
                  CustomTextFormField(
                    label: LocaleKeys.password.tr(),
                    isPassword: true,
                    controller: passwordController,
                    validator: (String? value) {
                      return validatePassword(value!);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCheckBoxWithText(
                        text: LocaleKeys.remember_me.tr(),
                      ),
                      CustomTextButton(
                        onPressed: () {
                          MagicRouter.navigateTo(ForgetPasswordBody());
                        },
                        text: LocaleKeys.forget_password.tr(),
                        size: SizeConfig.defaultSize! * 1.5,
                      )
                    ],
                  ),
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
                  CustomStrockButton(
                      text: LocaleKeys.sign_up.tr(),
                      onTap: () {
                        MagicRouter.navigateTo(RegisterBody());
                      }),
                  const VerticalSpace(value: 5),
                  SizedBox(
                      height: SizeConfig.defaultSize! * 2,
                      child: Image.asset(
                        'asset/images/social.png',
                        color: kMainColor,
                      )),
                  const VerticalSpace(value: 2),
                ],
              ),
            ),
          );
        },
      );

  }
}
