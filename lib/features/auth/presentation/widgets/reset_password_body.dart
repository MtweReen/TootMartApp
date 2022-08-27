// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/helper/validation.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/features/layout/layout.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import '../../../../../core/utiles/size_config.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../core/constants/colors.dart';

class ResetPasswordBody extends StatelessWidget {
   ResetPasswordBody({Key? key}) : super(key: key);

   final _formKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

   FocusNode codeFocusNode = FocusNode();
   FocusNode passwordFocusNode = FocusNode();
   FocusNode confirmPasswordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const  VerticalSpace(value: 3),
              Center(
                child: Text(
                  LocaleKeys.reset_new_password.tr(),
                  style: headingStyle.copyWith(color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
              VerticalSpace(value: SizeConfig.defaultSize! * 0.1),
              Center(
                child: Text(
                  LocaleKeys.please_enter_phone.tr(),
                  style: TextStyle(
                      color: Colors.grey, fontSize: SizeConfig.defaultSize! * 1.3),
                ),
              ),
              VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
              Text(
                LocaleKeys.code_sent.tr(),
                style: headingStyle.copyWith(color: colorGrey),
              ),
              const VerticalSpace(value: 1),
              CustomTextFormField(
                focusNode: codeFocusNode,
                label:  LocaleKeys.code_sent.tr(),
                controller: codeController,
                inputType: TextInputType.phone,
                validator: (String? value){
                  return validate(value!);
                },
                onEditingComplete: () {
                  codeFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
              Text(
                LocaleKeys.password.tr(),
                style: headingStyle.copyWith(color: colorGrey),
              ),
              const VerticalSpace(value: 1),
              CustomTextFormField(
                focusNode: passwordFocusNode,
                label: LocaleKeys.new_password.tr(),
                controller: passwordController,
                isPassword: true,
                inputType: TextInputType.text,
                validator: (String? value){
                  return validatePassword(value!);
                },
                onEditingComplete: () {
                  passwordFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                },
              ),
              VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
              Text(
                LocaleKeys.confirm_password.tr(),
                style: headingStyle.copyWith(color: colorGrey),
              ),
              const VerticalSpace(value: 1),
              CustomTextFormField(
                focusNode: confirmPasswordFocusNode,
                label:  LocaleKeys.confirm_password.tr(),
                isPassword: true,
                controller: confirmPasswordController,
                inputType: TextInputType.text,
                validator: (String? value){
                  return validateConfirmPassword(value!,passwordController.text,);
                },
                onEditingComplete: () {
                  confirmPasswordFocusNode.unfocus();
                },
              ),
              VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
              CustomGeneralButton(text: LocaleKeys.confirm.tr(), onTap: () {
                // if (_formKey.currentState!.validate()) {
                //  // MagicRouter.navigateTo(const HomeLayoutView());
                // }
                MagicRouter.navigateTo( const LayoutScreen(index:0));
              }),
            ],
          ),
        ),
      );
  }
}
