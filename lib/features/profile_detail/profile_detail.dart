import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/features/profile_detail/componnent/form.dart';

import '../../translations/locale_keys.g.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
          title: LocaleKeys.account_details.tr(),
          context: context,
          press: () => Navigator.pop(context)),
      body:const EditProfileForm()
    );
  }
}
