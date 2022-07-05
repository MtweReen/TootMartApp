import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../translations/locale_keys.g.dart';

TextEditingController oldPassword = TextEditingController();
TextEditingController newPassword = TextEditingController();
TextEditingController confirmNewPassword = TextEditingController();

FocusNode focusNode = FocusNode();
FocusNode newPassNode = FocusNode();
FocusNode confirmPasswordNode = FocusNode();

void changePasswordDialog({required context}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  LocaleKeys.change_password.tr(),
                  style: headingStyle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(LocaleKeys.OLD_PASS.tr(), style: headingStyle.copyWith(
                color: colorGrey,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: "",
                controller: oldPassword,
                focusNode: focusNode,
                onEditingComplete: () {
                  focusNode.unfocus();
                  FocusScope.of(context).requestFocus(newPassNode);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                LocaleKeys.new_password.tr(),
                style: headingStyle.copyWith(
                color: colorGrey,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: "",
                controller: newPassword,
                focusNode: newPassNode,
                onEditingComplete: () {
                  newPassNode.unfocus();
                  FocusScope.of(context).requestFocus(confirmPasswordNode);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                LocaleKeys.confirm_password.tr(),
                style: headingStyle.copyWith(
                color: colorGrey,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: "",
                controller: confirmNewPassword,
                focusNode: confirmPasswordNode,
                onEditingComplete: () {
                  confirmPasswordNode.unfocus();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomGeneralButton(
                text: LocaleKeys.send.tr(),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
