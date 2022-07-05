import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/utiles/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({Key? key}) : super(key: key);

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  FocusNode nameFocuse = FocusNode();
  FocusNode messageFocuse = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
        title: LocaleKeys.CONTACT_US.tr(),
        context: context,
        press: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.first_name.tr(),
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
                onEditingComplete: () {
                  nameFocuse.unfocus();
                  FocusScope.of(context).requestFocus(messageFocuse);
                },
              ),
              const VerticalSpace(value: 3),
              Text(
                LocaleKeys.message.tr(),
                style: headingStyle.copyWith(
                    color: colorGrey,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    fontSize: SizeConfig.screenWidth! * 0.04),
              ),
              const VerticalSpace(value: 1.5),
              CustomTextFormField(
                controller: message,
                maxLines: 5,
                focusNode: messageFocuse,
                onEditingComplete: () {
                  messageFocuse.unfocus();
                },
              ),
              const VerticalSpace(value: 3),
              CustomGeneralButton(text: LocaleKeys.send.tr(), onTap: () {}),
              const VerticalSpace(value: 5),
              Center(
                child: SizedBox(
                    height: SizeConfig.defaultSize! * 2,
                    child: Image.asset(
                      'asset/images/social.png',
                      color: kMainColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
