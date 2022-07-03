import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/helper/validation.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utiles/size_config.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/space_widget.dart';

class ResetPasswordBody extends StatelessWidget {
   ResetPasswordBody({Key? key}) : super(key: key);

   final _formKey=GlobalKey<FormState>();
  var codeController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAppBar(),
              const  VerticalSpace(value: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.reset_new_password.tr(),
                      style: TextStyle(
                          color: kMainColor, fontSize: SizeConfig.defaultSize! * 2),
                    ),
                    VerticalSpace(value: SizeConfig.defaultSize! * 0.1),
                    Text(
                      LocaleKeys.please_enter_phone.tr(),
                      style: TextStyle(
                          color: Colors.grey, fontSize: SizeConfig.defaultSize! * 1.3),
                    ),
                    VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
                    CustomTextFormField(
                      label:  LocaleKeys.code_sent.tr(),
                      controller: codeController,
                      inputType: TextInputType.phone,
                      validator: (String? value){
                        return validate(value!);
                      },
                    ),
                    VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
                    CustomTextFormField(
                      label: LocaleKeys.new_password.tr(),
                      controller: passwordController,
                      isPassword: true,
                      inputType: TextInputType.text,
                      validator: (String? value){
                        return validatePassword(value!);
                      },
                    ),
                    VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
                    CustomTextFormField(
                      label:  LocaleKeys.confirm_password.tr(),
                      isPassword: true,
                      controller: confirmPasswordController,
                      inputType: TextInputType.text,
                      validator: (String? value){
                        return validateConfirmPassword(value!,passwordController.text,);
                      },
                    ),
                    VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
                    CustomGeneralButton(text: LocaleKeys.confirm.tr(), onTap: () {
                      if (_formKey.currentState!.validate()) {
                       // MagicRouter.navigateTo(const HomeLayoutView());
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
