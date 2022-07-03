import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/helper/validation.dart';
import 'package:toot_mart/core/utiles/size_config.dart';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/custom_container.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_text_field.dart';
import '../../data/business_logic/auth_cubit.dart';
import '../../data/business_logic/auth_state.dart';

class AccountDetails extends StatelessWidget {
  AccountDetails({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var dialogOldPasswordController = TextEditingController();
  var dialogNewPasswordController = TextEditingController();
  var dialogConfirmPasswordController = TextEditingController();
  final _formKeyDialog = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context,state){},
          builder: (context,state){
            return SizedBox(
              height: SizeConfig.screenHeight,
              child: CustomContainer(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        const VerticalSpace(value: 2),
                        CustomTextFormField(
                            hint: kUser!.data!.user!.name!,
                            controller: nameController,
                            inputType: TextInputType.name,
                            validator: (String? value) {
                              return validateName(value!);
                            }),
                        const VerticalSpace(value: 2),
                        CustomTextFormField(
                            hint: kUser!.data!.user!.mobile!,
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            validator: (String? value) {
                              return validateMobile(value!);
                            }),
                        const VerticalSpace(value: 2),
                        CustomTextFormField(
                            hint: kUser!.data!.user!.email!,
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              return validateEmail(value!);
                            }),
                        const VerticalSpace(value: 3),
                        CustomGeneralButton(
                            text: LocaleKeys.save.tr(),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                AuthCubit.get(context).editProfile(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            }),
                        const VerticalSpace(value: 2),
                        CustomGeneralButton(
                            text: LocaleKeys.change_password.tr(),
                            color: Colors.transparent,
                            textColor: kMainColor,
                            onTap: () {
                              _showCustomDialog(
                                  context,
                                  dialogOldPasswordController,
                                  dialogNewPasswordController,
                                  dialogConfirmPasswordController,
                                  _formKeyDialog);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showCustomDialog(
    BuildContext context,
    dialogOldPasswordController,
    dialogNewPasswordController,
    dialogConfirmPasswordController,
    formKeyDialog) {
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
            title: Center(child: Text(LocaleKeys.change_password.tr())),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'LocaleKeys.old_password.tr()',
                      controller: dialogOldPasswordController,
                      isPassword:true,
                      validator: (String? value) {
                        return validatePassword(value!);
                      },
                    ),
                    const VerticalSpace(value: 1),
                    CustomTextFormField(
                      label: LocaleKeys.new_password.tr(),
                      controller: dialogNewPasswordController,
                      isPassword:true,
                      validator: (String? value) {
                        return validatePassword(value!);
                      },
                    ),
                    const VerticalSpace(value: 2),
                    CustomTextFormField(
                      label: LocaleKeys.confirm_password.tr(),
                      controller: dialogConfirmPasswordController,
                      isPassword:true,
                      validator: (String? value) {
                        return validateConfirmPassword(
                            value!, dialogNewPasswordController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[

              Row(
                children: [
                  SizedBox(
                    height: SizeConfig.defaultSize!*5,
                    width:  SizeConfig.defaultSize!*13,
                    child: CustomGeneralButton(
                        text: LocaleKeys.save.tr(),
                        onTap: () {
                          if (formKeyDialog.currentState!.validate()) {
                            AuthCubit.get(context).changePassword(
                                oldPassword: dialogOldPasswordController.text,
                                newPassword: dialogNewPasswordController.text,
                                newPasswordConfirmation:
                                    dialogConfirmPasswordController.text);
                           // Navigator.of(context).pop();
                          }
                        }),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: SizeConfig.defaultSize!*5,
                    width:  SizeConfig.defaultSize!*13,
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
