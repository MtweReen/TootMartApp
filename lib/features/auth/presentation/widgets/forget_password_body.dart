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

class ForgetPasswordBody extends StatelessWidget {
   ForgetPasswordBody({Key? key}) : super(key: key);
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const CustomAppBar(),
            const VerticalSpace(value: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.forget_password.tr(),
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
                    label: LocaleKeys.phone_number.tr(),
                    inputType: TextInputType.phone,
                    validator: (String? value){
                      return validateMobile(value!);
                    },
                  ),
                  VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
                  CustomGeneralButton(text:LocaleKeys.send.tr(), onTap: () {
                    if (_formKey.currentState!.validate()) {
                    //  MagicRouter.navigateTo(ResetPasswordBody());
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
