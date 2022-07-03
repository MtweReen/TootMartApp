import 'package:toot_mart/core/widgets/custom_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/validation.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/widgets/custom_container.dart';
import '../../data/business_logic/auth_cubit.dart';
import '../../data/business_logic/auth_state.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterUserSuccessState) {
          if(AuthCubit.get(context).user !=null) {
            CasheHelper.SaveUser(user: AuthCubit
                .get(context)
                .user!);
            kUser = AuthCubit
                .get(context)
                .user;
          }
         // MagicRouter.navigateTo(const HomeLayoutView());
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          drawer: const CustomDrawer(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: CustomContainer(
              child: Form(
                key: _formKey,
                child: Container(
                  height: SizeConfig.screenHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.sign_up.tr(),
                        style: TextStyle(color: kMainColor, fontSize: 30),
                      ),
                      VerticalSpace(value: SizeConfig.defaultSize! * 0.5),
                      CustomTextFormField(
                        label: 'LocaleKeys.name.tr()',
                        inputType: TextInputType.name,
                        controller: nameController,
                        validator: (String? value) {
                          return validateName(value!);
                        },
                      ),
                      VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
                      CustomTextFormField(
                        label: LocaleKeys.phone_number.tr(),
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        validator: (String? value) {
                          return validateMobile(value!);
                        },
                      ),
                      VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
                      CustomTextFormField(
                        inputType: TextInputType.emailAddress,
                        label: LocaleKeys.email.tr(),
                        controller: emailController,
                        validator: (String? value) {
                          return validateEmail(value!);
                        },
                      ),
                      VerticalSpace(value: SizeConfig.defaultSize! * 0.2),
                      CustomTextFormField(
                        label: LocaleKeys.password.tr(),
                        isPassword: true,
                        controller: passwordController,
                        validator: (String? value) {
                          return validatePassword(value!);
                        },
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: SizeConfig.defaultSize! * 5.5,
                              width: SizeConfig.defaultSize! * 5.5,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        Colors.grey // Your color
                                    ),
                                child: Checkbox(
                                    activeColor: kMainColor,
                                    value: accepted,
                                    onChanged: (value) {
                                      accepted = !accepted;
                                      AuthCubit.get(context)
                                          .emit(CheckedSuccessState());
                                    }),
                              )),
                          Text(LocaleKeys.accept_all_conditions_and_terms.tr(),
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: SizeConfig.defaultSize! * 1.8,
                              )),
                        ],
                      ),
                      if (state is! RegisterUserLoadingState)
                        CustomGeneralButton(
                            isActive: accepted,
                            text: LocaleKeys.sign_up.tr(),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.RegisterUser(
                                    nameController.text,
                                    phoneController.text,
                                    emailController.text,
                                    passwordController.text);
                              }
                            }),
                      if (state is RegisterUserLoadingState)
                        Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      const VerticalSpace(value: 5),
                      SizedBox(
                          height: SizeConfig.defaultSize! * 2,
                          child: Image.asset(
                            'assets/images/social.png',
                            color: kMainColor,
                          )),
                      const VerticalSpace(value: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
