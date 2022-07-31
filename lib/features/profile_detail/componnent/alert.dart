import 'package:flutter/material.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helper/validation.dart';
import '../../../core/utiles/size_config.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../auth/data/business_logic/auth_cubit.dart';

TextEditingController dialogOldPasswordController = TextEditingController();
TextEditingController dialogNewPasswordController = TextEditingController();
TextEditingController dialogConfirmPasswordController = TextEditingController();

FocusNode focusNode = FocusNode();
FocusNode newPassNode = FocusNode();
FocusNode confirmPasswordNode = FocusNode();

var formKeyDialog = GlobalKey<FormState>();

void changePasswordDialog({required BuildContext context}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: Form(
          key: formKeyDialog,
          child: AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      LocaleKeys.change_password.tr(),
                      style: headingStyle,
                    ),
                  ),
                  VerticalSpace(value: 2.5),
                  Text(
                    LocaleKeys.OLD_PASS.tr(),
                    style: headingStyle.copyWith(
                        color: colorGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  VerticalSpace(value: 1),
                  CustomTextFormField(
                    controller: dialogOldPasswordController,
                    isPassword: true,
                    focusNode: focusNode,
                    onEditingComplete: () {
                      focusNode.unfocus();
                      FocusScope.of(context).requestFocus(newPassNode);
                    },
                    validator: (String? value) {
                      return validatePassword(value!);
                    },
                  ),
                  const VerticalSpace(value: 1.5),
                  Text(
                    LocaleKeys.new_password.tr(),
                    style: headingStyle.copyWith(
                        color: colorGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  const VerticalSpace(value: 1),
                  CustomTextFormField(
                    controller: dialogNewPasswordController,
                    isPassword: true,
                    validator: (String? value) {
                      return validatePassword(value!);
                    },
                    focusNode: newPassNode,
                    onEditingComplete: () {
                      newPassNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(confirmPasswordNode);
                    },
                  ),
                  const VerticalSpace(value: 1.5),
                  Text(
                    LocaleKeys.confirm_password.tr(),
                    style: headingStyle.copyWith(
                        color: colorGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  const VerticalSpace(value: 1),
                  CustomTextFormField(
                    controller: dialogConfirmPasswordController,
                    isPassword: true,
                    validator: (String? value) {
                      return validateConfirmPassword(
                          value!, dialogNewPasswordController.text);
                    },
                    focusNode: confirmPasswordNode,
                    onEditingComplete: () {
                      confirmPasswordNode.unfocus();
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  SizedBox(
                    height: SizeConfig.defaultSize! * 5,
                    width: SizeConfig.defaultSize! * 13,
                    child: CustomGeneralButton(
                        text: LocaleKeys.save.tr(),
                        onTap: () {
                          if (formKeyDialog.currentState!.validate()) {
                            AuthCubit.get(context).changePassword(
                                oldPassword: dialogOldPasswordController.text,
                                newPassword: dialogNewPasswordController.text,
                                newPasswordConfirmation:
                                    dialogConfirmPasswordController.text);
                            dialogOldPasswordController.clear();
                            dialogConfirmPasswordController.clear();
                            dialogNewPasswordController.clear();
                            MagicRouter.pop();
                          }
                        }),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 5,
                    width: SizeConfig.defaultSize! * 13,
                    child: CustomGeneralButton(
                        text: LocaleKeys.cancel.tr(),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
