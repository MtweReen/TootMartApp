import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';

import '../../core/widgets/profile_item.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translateString('Account', 'الحساب'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translateString('Hello', 'مرحبا'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.defaultSize! * 3),
                ),
                Icon(Icons.settings_outlined,
                    size: SizeConfig.defaultSize! * 4),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: SizeConfig.defaultSize! * 18,
                    child: CustomGeneralButton(
                        text: translateString('Log in', 'تسجيل الدخول'),
                        onTap: () {})),
                Container(
                  width: SizeConfig.defaultSize! * 18,
                  child: CustomStrockButton(
                      text: translateString('Register', 'تسجيل'), onTap: () {}),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: ProfileCardItem(
                    title: 'LocaleKeys.account.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  child: ProfileCardItem(
                    title: ' LocaleKeys.wallet.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  child: ProfileCardItem(
                    title: 'LocaleKeys.ABOUT.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  child: ProfileCardItem(
                    title: 'LocaleKeys.TERMS.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  child: ProfileCardItem(
                    title: 'LocaleKeys.LANG.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  child: ProfileCardItem(
                    title: 'LocaleKeys.CONTACT_US.tr()',
                  ),
                ),
                SizedBox(
                  height: h * 0.06,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
