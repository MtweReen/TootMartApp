// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/helper/validation.dart';
import 'package:toot_mart/features/account/account.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_state.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utiles/size_config.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/space_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(value: 3),
            Center(
              child: Text(
                LocaleKeys.forget_password.tr(),
                style: headingStyle.copyWith(color: Colors.black),
              ),
            ),
            VerticalSpace(value: SizeConfig.defaultSize! * 0.1),
            Center(
              child: Text(
                LocaleKeys.please_enter_phone.tr(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: SizeConfig.defaultSize! * 1.3),
              ),
            ),
            VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
            Text(
              LocaleKeys.phone_number.tr(),
              style: headingStyle.copyWith(color: colorGrey),
            ),
            const VerticalSpace(value: 1),
            CustomTextFormField(
              label: LocaleKeys.phone_number.tr(),
              inputType: TextInputType.phone,
              controller: phone,
              validator: (String? value) {
                return validateMobile(value!);
              },
            ),
            const VerticalSpace(value: 7),
            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if(state is ForgetPasswordSuccessState){
                  AuthCubit.get(context).changeUserState(AccountStates.RESET_PASSWORD);
                }
              },
              builder: (context, state) {
                return CustomGeneralButton(
                    text: LocaleKeys.send.tr(),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AuthCubit.get(context)
                            .forgetPassword(phone: phone.text);
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
