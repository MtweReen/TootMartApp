import 'package:flutter/material.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toot_mart/features/profile_detail/componnent/alert.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../translations/locale_keys.g.dart';


class EditProfileForm extends StatefulWidget {
  const EditProfileForm({ Key? key }) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {

 TextEditingController name = TextEditingController();
 TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  FocusNode nameFocuse = FocusNode();
  FocusNode phoneFocuse = FocusNode();
  FocusNode emailFocuse = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return  SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const VerticalSpace(value: 2),
              Center(
                child: Text(
                  LocaleKeys.account_details.tr(),
                  style: headingStyle.copyWith(color: Colors.black),
                ),
              ),
              const VerticalSpace(value: 3),
              Text(
                LocaleKeys.user_name.tr(),
                style: headingStyle.copyWith(
                    color: colorGrey,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: SizeConfig.screenWidth! * 0.04),
              ),
              const VerticalSpace(value: 1.5),
              CustomTextFormField(
                controller: name,
                focusNode: nameFocuse,
                hint: kUser!.body!.user!.name,
                onEditingComplete: () {
                  nameFocuse.unfocus();
                  FocusScope.of(context).requestFocus(emailFocuse);
                },
              ),
              const VerticalSpace(value: 2),
              Text(
                LocaleKeys.email.tr(),
                style: headingStyle.copyWith(
                    color: colorGrey,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: SizeConfig.screenWidth! * 0.04),
              ),
              const VerticalSpace(value: 1.5),
              CustomTextFormField(
                controller: email,
                focusNode: emailFocuse,
                hint: kUser!.body!.user!.email,

                onEditingComplete: () {
                  emailFocuse.unfocus();
                  FocusScope.of(context).requestFocus(phoneFocuse);
                },
              ),
              const VerticalSpace(value: 2),

              Text(
                LocaleKeys.phone_number.tr(),
                style: headingStyle.copyWith(
                    color: colorGrey,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: SizeConfig.screenWidth! * 0.04),
              ),
              const VerticalSpace(value: 1.5),
              CustomTextFormField(
                controller: phone,
                focusNode: phoneFocuse,
                hint: kUser!.body!.user!.phone,

                onEditingComplete: () {
                  phoneFocuse.unfocus();

                },
              ),
              const VerticalSpace(value: 3),
              CustomGeneralButton(text: LocaleKeys.save_edits.tr(), onTap: () {

              }),
              const VerticalSpace(value: 1.5),
               Center(
                 child: TextButton(
                    onPressed: () {
                      changePasswordDialog(context: context);
                    },
                    child: Text(
                       LocaleKeys.change_password.tr(),
                      style: headingStyle.copyWith(
                          color: kMainColor,
                       
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenWidth! * 0.045),
                    ),
                  ),
               ),
            ],
          ),
        ),     
      );
  }
}